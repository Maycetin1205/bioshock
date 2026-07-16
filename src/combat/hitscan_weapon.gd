class_name HitscanWeapon
extends Node

const DamagePacketScript := preload("res://src/combat/damage_packet.gd")

signal ammo_changed(in_magazine: int, reserve: int)
signal reload_state_changed(is_reloading: bool)
signal fired
signal hit_confirmed(applied_damage: float)

@export var camera_path: NodePath
@export var view_model_path: NodePath
@export_range(1, 100, 1) var magazine_size: int = 8
@export_range(0, 999, 1) var starting_reserve_ammo: int = 32
@export_range(0, 999, 1) var maximum_reserve_ammo: int = 96
@export_range(0.0, 1000.0, 1.0) var damage: float = 24.0
@export_range(1.0, 250.0, 1.0) var range: float = 65.0
@export_range(0.05, 5.0, 0.05) var fire_interval: float = 0.32
@export_range(0.1, 10.0, 0.05) var reload_duration: float = 1.15

@onready var camera: Camera3D = get_node(camera_path) as Camera3D
@onready var view_model: Node3D = get_node_or_null(view_model_path) as Node3D

var ammo_in_magazine: int
var reserve_ammo: int
var is_reloading: bool = false
var _cooldown_remaining: float = 0.0
var _reload_remaining: float = 0.0
var _owner_actor: CollisionObject3D
var _view_model_rest_position: Vector3
var _recoil_tween: Tween


func _ready() -> void:
	_owner_actor = get_parent() as CollisionObject3D
	ammo_in_magazine = magazine_size
	reserve_ammo = mini(starting_reserve_ammo, maximum_reserve_ammo)
	if view_model != null:
		_view_model_rest_position = view_model.position
	_publish_ammo()


func _process(delta: float) -> void:
	_cooldown_remaining = maxf(0.0, _cooldown_remaining - delta)
	if is_reloading:
		_reload_remaining -= delta
		if _reload_remaining <= 0.0:
			_finish_reload()


func _unhandled_input(event: InputEvent) -> void:
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		return
	if event.is_action_pressed("weapon_fire"):
		try_fire()
	elif event.is_action_pressed("weapon_reload"):
		start_reload()


func try_fire() -> bool:
	if is_reloading or _cooldown_remaining > 0.0:
		return false
	if ammo_in_magazine <= 0:
		GameEvents.notification_requested.emit("Magazin leer")
		start_reload()
		return false
	ammo_in_magazine -= 1
	_cooldown_remaining = fire_interval
	_publish_ammo()
	fired.emit()
	_fire_ray()
	_play_recoil()
	_flash_muzzle()
	return true


func start_reload() -> bool:
	if is_reloading or ammo_in_magazine >= magazine_size or reserve_ammo <= 0:
		return false
	is_reloading = true
	_reload_remaining = reload_duration
	reload_state_changed.emit(true)
	GameEvents.weapon_reload_changed.emit(true)
	return true


func add_reserve_ammo(amount: int) -> int:
	if amount <= 0:
		return 0
	var previous := reserve_ammo
	reserve_ammo = mini(maximum_reserve_ammo, reserve_ammo + amount)
	var accepted := reserve_ammo - previous
	if accepted > 0:
		_publish_ammo()
	return accepted


func cancel_reload() -> void:
	if not is_reloading:
		return
	is_reloading = false
	_reload_remaining = 0.0
	reload_state_changed.emit(false)
	GameEvents.weapon_reload_changed.emit(false)


func publish_state() -> void:
	_publish_ammo()
	GameEvents.weapon_reload_changed.emit(is_reloading)


func _finish_reload() -> void:
	var required := magazine_size - ammo_in_magazine
	var transferred := mini(required, reserve_ammo)
	ammo_in_magazine += transferred
	reserve_ammo -= transferred
	is_reloading = false
	_reload_remaining = 0.0
	_publish_ammo()
	reload_state_changed.emit(false)
	GameEvents.weapon_reload_changed.emit(false)


func _fire_ray() -> void:
	var origin := camera.global_position
	var endpoint := origin + (-camera.global_transform.basis.z * range)
	var query := PhysicsRayQueryParameters3D.create(origin, endpoint)
	if _owner_actor != null:
		query.exclude = [_owner_actor.get_rid()]
	var hit := camera.get_world_3d().direct_space_state.intersect_ray(query)
	if hit.is_empty():
		return
	var receiver := _resolve_damage_receiver(hit.get("collider"))
	if receiver == null:
		return
	var packet = DamagePacketScript.new(damage, DamagePacketScript.DamageType.KINETIC, _owner_actor, hit.get("position", Vector3.ZERO), hit.get("normal", Vector3.ZERO))
	var applied_damage := 0.0
	if receiver.has_method("apply_damage_packet"):
		applied_damage = float(receiver.call("apply_damage_packet", packet))
	elif receiver.has_method("apply_damage"):
		applied_damage = float(receiver.call("apply_damage", damage, _owner_actor))
	if applied_damage > 0.0:
		hit_confirmed.emit(applied_damage)
		GameEvents.hit_confirmed.emit(applied_damage)


func _resolve_damage_receiver(candidate: Variant) -> Node:
	if not candidate is Node:
		return null
	var current := candidate as Node
	for _index in range(6):
		if current.has_method("apply_damage_packet") or current.has_method("apply_damage"):
			return current
		current = current.get_parent()
		if current == null:
			break
	return null


func _publish_ammo() -> void:
	ammo_changed.emit(ammo_in_magazine, reserve_ammo)
	GameEvents.weapon_ammo_changed.emit(ammo_in_magazine, reserve_ammo)


func _play_recoil() -> void:
	if view_model == null:
		return
	if _recoil_tween != null:
		_recoil_tween.kill()
	view_model.position = _view_model_rest_position + Vector3(0.0, 0.015, 0.07)
	_recoil_tween = create_tween()
	_recoil_tween.tween_property(view_model, "position", _view_model_rest_position, 0.11)


func _flash_muzzle() -> void:
	var flash := OmniLight3D.new()
	flash.light_color = Color(1.0, 0.72, 0.35)
	flash.light_energy = 3.5
	flash.omni_range = 3.0
	camera.add_child(flash)
	await get_tree().create_timer(0.045).timeout
	if is_instance_valid(flash):
		flash.queue_free()
