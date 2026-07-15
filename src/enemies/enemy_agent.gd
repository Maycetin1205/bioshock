class_name EnemyAgent
extends CharacterBody3D

const HealthComponentScript := preload("res://src/components/health_component.gd")

@export_range(0.1, 20.0, 0.1) var movement_speed: float = 2.4
@export_range(1.0, 50.0, 0.5) var detection_distance: float = 11.0
@export_range(0.5, 10.0, 0.1) var attack_distance: float = 1.5
@export_range(0.0, 1000.0, 1.0) var attack_damage: float = 12.0
@export_range(0.1, 10.0, 0.1) var attack_cooldown: float = 1.0

var _health: HealthComponent
var _target: Node3D
var _attack_timer: float = 0.0
var _stun_timer: float = 0.0
var _gravity: float = float(ProjectSettings.get_setting("physics/3d/default_gravity", 9.8))
var _material: StandardMaterial3D


func _ready() -> void:
	add_to_group("enemies")
	_create_placeholder_if_needed()
	_create_health_component()
	_target = get_tree().get_first_node_in_group("player") as Node3D


func _physics_process(delta: float) -> void:
	_attack_timer = maxf(0.0, _attack_timer - delta)

	if not is_on_floor():
		velocity.y -= _gravity * delta

	if _stun_timer > 0.0:
		_stun_timer -= delta
		velocity.x = move_toward(velocity.x, 0.0, movement_speed * 5.0 * delta)
		velocity.z = move_toward(velocity.z, 0.0, movement_speed * 5.0 * delta)
		move_and_slide()
		return

	if _target == null or not is_instance_valid(_target):
		_target = get_tree().get_first_node_in_group("player") as Node3D
		move_and_slide()
		return

	var offset := _target.global_position - global_position
	var planar_offset := Vector3(offset.x, 0.0, offset.z)
	var distance := planar_offset.length()

	if distance <= detection_distance and _has_line_of_sight():
		if distance > attack_distance:
			var direction := planar_offset.normalized()
			velocity.x = direction.x * movement_speed
			velocity.z = direction.z * movement_speed
			look_at(Vector3(_target.global_position.x, global_position.y, _target.global_position.z), Vector3.UP, true)
		else:
			velocity.x = move_toward(velocity.x, 0.0, movement_speed * 8.0 * delta)
			velocity.z = move_toward(velocity.z, 0.0, movement_speed * 8.0 * delta)
			_try_attack()
	else:
		velocity.x = move_toward(velocity.x, 0.0, movement_speed * 4.0 * delta)
		velocity.z = move_toward(velocity.z, 0.0, movement_speed * 4.0 * delta)

	move_and_slide()


func apply_damage(amount: float, source: Variant = null) -> float:
	return _health.damage(amount, source)


func apply_electric_hit(damage: float, stun_duration: float, source: Variant = null) -> void:
	_stun_timer = maxf(_stun_timer, stun_duration)
	_health.damage(damage, source)
	_set_emission(Color(0.2, 0.75, 1.0), 2.5)
	GameEvents.notification_requested.emit("Ziel elektrisiert")
	_reset_material_later(stun_duration)


func _try_attack() -> void:
	if _attack_timer > 0.0 or _target == null:
		return
	_attack_timer = attack_cooldown
	if _target.has_method("apply_damage"):
		_target.call("apply_damage", attack_damage, self)
		GameEvents.notification_requested.emit("Gegnerischer Treffer")


func _has_line_of_sight() -> bool:
	var origin := global_position + Vector3.UP * 0.6
	var endpoint := _target.global_position + Vector3.UP * 0.4
	var query := PhysicsRayQueryParameters3D.create(origin, endpoint)
	query.exclude = [get_rid()]
	var hit := get_world_3d().direct_space_state.intersect_ray(query)
	return not hit.is_empty() and hit.get("collider") == _target


func _create_health_component() -> void:
	_health = HealthComponentScript.new() as HealthComponent
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


func _set_emission(color: Color, energy: float) -> void:
	_material.emission_enabled = true
	_material.emission = color
	_material.emission_energy_multiplier = energy


func _reset_material_later(delay: float) -> void:
	await get_tree().create_timer(delay).timeout
	if not is_instance_valid(self) or _material == null:
		return
	_material.emission_enabled = false


func _on_died(_source: Variant) -> void:
	GameEvents.notification_requested.emit("Gegner ausgeschaltet")
	queue_free()
