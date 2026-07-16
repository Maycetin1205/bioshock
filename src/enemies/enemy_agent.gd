class_name EnemyAgent
extends CharacterBody3D

const HealthComponentScript := preload("res://src/components/health_component.gd")
const DamagePacketScript := preload("res://src/combat/damage_packet.gd")

signal state_changed(previous_state: int, current_state: int)

enum State { IDLE, SUSPICIOUS, CHASING, ATTACKING, STUNNED, DEAD }

@export_range(0.1, 20.0, 0.1) var movement_speed: float = 2.4
@export_range(1.0, 50.0, 0.5) var detection_distance: float = 12.0
@export_range(0.5, 10.0, 0.1) var attack_distance: float = 1.5
@export_range(0.0, 1000.0, 1.0) var attack_damage: float = 12.0
@export_range(0.1, 10.0, 0.1) var attack_cooldown: float = 1.0
@export_range(0.5, 30.0, 0.5) var memory_duration: float = 4.0

var _health: Node
var _target: Node3D
var _state: int = State.IDLE
var _attack_timer: float = 0.0
var _stun_timer: float = 0.0
var _memory_timer: float = 0.0
var _last_known_position: Vector3
var _gravity: float = float(ProjectSettings.get_setting("physics/3d/default_gravity", 9.8))
var _material: StandardMaterial3D


func _ready() -> void:
	add_to_group("enemies")
	_create_placeholder_if_needed()
	_create_health_component()
	_target = get_tree().get_first_node_in_group("player") as Node3D
	_set_state(State.IDLE, true)


func _physics_process(delta: float) -> void:
	if _state == State.DEAD:
		return
	_attack_timer = maxf(0.0, _attack_timer - delta)
	if not is_on_floor():
		velocity.y -= _gravity * delta
	if _target == null or not is_instance_valid(_target):
		_target = get_tree().get_first_node_in_group("player") as Node3D
	if _state == State.STUNNED:
		_update_stunned(delta)
		move_and_slide()
		return
	var can_see_target := _target != null and _is_target_visible()
	if can_see_target:
		_last_known_position = _target.global_position
		_memory_timer = memory_duration
		var target_distance := _planar_distance_to(_target.global_position)
		_set_state(State.ATTACKING if target_distance <= attack_distance else State.CHASING)
	elif _state == State.CHASING or _state == State.ATTACKING:
		_set_state(State.SUSPICIOUS)
	match _state:
		State.IDLE:
			_brake(delta)
		State.SUSPICIOUS:
			_update_suspicious(delta)
		State.CHASING:
			_move_toward_position(_last_known_position)
		State.ATTACKING:
			_brake(delta)
			_face_target()
			_try_attack()
	move_and_slide()


func apply_damage(amount: float, source: Variant = null) -> float:
	var packet_source: Node = source as Node if source is Node else null
	var packet = DamagePacketScript.new(amount, DamagePacketScript.DamageType.KINETIC, packet_source)
	return apply_damage_packet(packet)


func apply_damage_packet(packet: Variant) -> float:
	if _state == State.DEAD:
		return 0.0
	var applied := float(_health.damage(float(packet.amount), packet.source))
	if applied <= 0.0 or _state == State.DEAD:
		return applied
	if packet.source is Node3D:
		_last_known_position = (packet.source as Node3D).global_position
		_memory_timer = memory_duration
		if _state != State.STUNNED:
			_set_state(State.CHASING)
	return applied


func apply_electric_hit(damage: float, stun_duration: float, source: Variant = null) -> void:
	var packet_source: Node = source as Node if source is Node else null
	var packet = DamagePacketScript.new(damage, DamagePacketScript.DamageType.ELECTRIC, packet_source)
	var applied := apply_damage_packet(packet)
	if applied <= 0.0 or _state == State.DEAD:
		return
	_stun_timer = maxf(_stun_timer, stun_duration)
	_set_state(State.STUNNED)
	GameEvents.notification_requested.emit("Ziel elektrisiert")


func get_state_name() -> StringName:
	match _state:
		State.IDLE: return &"idle"
		State.SUSPICIOUS: return &"suspicious"
		State.CHASING: return &"chasing"
		State.ATTACKING: return &"attacking"
		State.STUNNED: return &"stunned"
		State.DEAD: return &"dead"
	return &"unknown"


func _update_stunned(delta: float) -> void:
	_stun_timer = maxf(0.0, _stun_timer - delta)
	_brake(delta)
	if is_zero_approx(_stun_timer):
		_set_state(State.SUSPICIOUS if _memory_timer > 0.0 else State.IDLE)


func _update_suspicious(delta: float) -> void:
	_memory_timer = maxf(0.0, _memory_timer - delta)
	if _memory_timer <= 0.0:
		_set_state(State.IDLE)
		return
	if _planar_distance_to(_last_known_position) > 0.65:
		_move_toward_position(_last_known_position)
	else:
		_brake(delta)


func _move_toward_position(destination: Vector3) -> void:
	var offset := destination - global_position
	var planar_offset := Vector3(offset.x, 0.0, offset.z)
	if planar_offset.is_zero_approx():
		return
	var direction := planar_offset.normalized()
	velocity.x = direction.x * movement_speed
	velocity.z = direction.z * movement_speed
	look_at(Vector3(destination.x, global_position.y, destination.z), Vector3.UP, true)


func _brake(delta: float) -> void:
	velocity.x = move_toward(velocity.x, 0.0, movement_speed * 8.0 * delta)
	velocity.z = move_toward(velocity.z, 0.0, movement_speed * 8.0 * delta)


func _face_target() -> void:
	if _target != null:
		look_at(Vector3(_target.global_position.x, global_position.y, _target.global_position.z), Vector3.UP, true)


func _try_attack() -> void:
	if _attack_timer > 0.0 or _target == null:
		return
	_attack_timer = attack_cooldown
	var packet = DamagePacketScript.new(attack_damage, DamagePacketScript.DamageType.MELEE, self, _target.global_position, Vector3.ZERO)
	if _target.has_method("apply_damage_packet"):
		_target.call("apply_damage_packet", packet)
	elif _target.has_method("apply_damage"):
		_target.call("apply_damage", attack_damage, self)
	GameEvents.notification_requested.emit("Gegnerischer Treffer")


func _is_target_visible() -> bool:
	if _target == null or _planar_distance_to(_target.global_position) > detection_distance:
		return false
	var origin := global_position + Vector3.UP * 0.65
	var endpoint := _target.global_position + Vector3.UP * 0.4
	var query := PhysicsRayQueryParameters3D.create(origin, endpoint)
	query.exclude = [get_rid()]
	var hit := get_world_3d().direct_space_state.intersect_ray(query)
	return not hit.is_empty() and hit.get("collider") == _target


func _planar_distance_to(destination: Vector3) -> float:
	var offset := destination - global_position
	return Vector2(offset.x, offset.z).length()


func _set_state(next_state: int, force: bool = false) -> void:
	if not force and _state == next_state:
		return
	var previous := _state
	_state = next_state
	_update_material_for_state()
	state_changed.emit(previous, _state)


func _create_health_component() -> void:
	_health = HealthComponentScript.new()
	_health.name = "HealthComponent"
	_health.max_health = 70.0
	add_child(_health)
	_health.died.connect(_on_died)


func _create_placeholder_if_needed() -> void:
	var mesh_instance := MeshInstance3D.new()
	mesh_instance.name = "MeshInstance3D"
	var capsule_mesh := CapsuleMesh.new()
	capsule_mesh.radius = 0.45
	capsule_mesh.height = 1.8
	_material = StandardMaterial3D.new()
	_material.albedo_color = Color(0.28, 0.18, 0.14)
	_material.roughness = 0.75
	capsule_mesh.material = _material
	mesh_instance.mesh = capsule_mesh
	add_child(mesh_instance)
	var collision := CollisionShape3D.new()
	collision.name = "CollisionShape3D"
	var shape := CapsuleShape3D.new()
	shape.radius = 0.45
	shape.height = 1.8
	collision.shape = shape
	add_child(collision)


func _update_material_for_state() -> void:
	if _material == null:
		return
	_material.emission_enabled = false
	match _state:
		State.IDLE: _material.albedo_color = Color(0.28, 0.18, 0.14)
		State.SUSPICIOUS: _material.albedo_color = Color(0.55, 0.34, 0.10)
		State.CHASING: _material.albedo_color = Color(0.52, 0.12, 0.08)
		State.ATTACKING: _material.albedo_color = Color(0.72, 0.06, 0.05)
		State.STUNNED:
			_material.emission_enabled = true
			_material.emission = Color(0.2, 0.75, 1.0)
			_material.emission_energy_multiplier = 2.5


func _on_died(_source: Variant) -> void:
	_set_state(State.DEAD)
	GameEvents.notification_requested.emit("Gegner ausgeschaltet")
	queue_free()
