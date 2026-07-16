class_name ElectricBurst
extends Node

@export var camera_path: NodePath
@export var energy_component_path: NodePath
@export_range(1.0, 100.0, 1.0) var energy_cost: float = 25.0
@export_range(1.0, 50.0, 0.5) var range: float = 14.0
@export_range(0.0, 1000.0, 1.0) var damage: float = 35.0
@export_range(0.0, 20.0, 0.1) var stun_duration: float = 2.5

@onready var camera: Camera3D = get_node(camera_path) as Camera3D
@onready var energy_component: Node = get_node(energy_component_path)

var _owner_actor: CollisionObject3D


func _ready() -> void:
	_owner_actor = get_parent() as CollisionObject3D


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ability_primary") and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		_cast()


func _cast() -> void:
	if not energy_component.try_spend(energy_cost):
		GameEvents.notification_requested.emit("Nicht genug Energie")
		return
	GameEvents.ability_used.emit(&"electric_burst")
	_flash_light()
	var origin := camera.global_position
	var endpoint := origin + (-camera.global_transform.basis.z * range)
	var query := PhysicsRayQueryParameters3D.create(origin, endpoint)
	if _owner_actor != null:
		query.exclude = [_owner_actor.get_rid()]
	var hit := camera.get_world_3d().direct_space_state.intersect_ray(query)
	if hit.is_empty():
		GameEvents.notification_requested.emit("Der Impuls trifft nichts")
		return
	var receiver := _resolve_receiver(hit.get("collider"))
	if receiver != null:
		receiver.call("apply_electric_hit", damage, stun_duration, _owner_actor)
	else:
		GameEvents.notification_requested.emit("Der Impuls entlädt sich an der Oberfläche")


func _resolve_receiver(candidate: Variant) -> Node:
	if not candidate is Node:
		return null
	var current: Node = candidate
	for _index in range(5):
		if current.has_method("apply_electric_hit"):
			return current
		current = current.get_parent()
		if current == null:
			break
	return null


func _flash_light() -> void:
	var flash := OmniLight3D.new()
	flash.light_energy = 4.0
	flash.omni_range = 4.0
	flash.light_color = Color(0.35, 0.75, 1.0)
	camera.add_child(flash)
	await get_tree().create_timer(0.08).timeout
	if is_instance_valid(flash):
		flash.queue_free()
