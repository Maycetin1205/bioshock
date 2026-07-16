class_name PoweredDoor
extends AnimatableBody3D

@export var open_offset: Vector3 = Vector3(0.0, 3.2, 0.0)
@export_range(0.05, 5.0, 0.05) var move_duration: float = 0.8

var is_powered: bool = false
var is_open: bool = false
var _closed_position: Vector3
var _active_tween: Tween
var _material: StandardMaterial3D


func _ready() -> void:
	_closed_position = position
	_create_placeholder_if_needed()
	_update_material()


func get_interaction_prompt(_actor: Node) -> String:
	if not is_powered:
		return "Sicherheitstür: kein Strom"
	return "Tür schließen" if is_open else "Tür öffnen"


func interact(_actor: Node) -> void:
	if not is_powered:
		GameEvents.notification_requested.emit("Die Tür hat keinen Strom")
		return
	set_open(not is_open)


func set_powered(value: bool) -> void:
	is_powered = value
	if not is_powered and is_open:
		set_open(false)
	_update_material()


func set_open(value: bool) -> void:
	if value == is_open:
		return

	is_open = value
	if _active_tween != null:
		_active_tween.kill()

	var target_position := _closed_position + open_offset if is_open else _closed_position
	_active_tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	_active_tween.tween_property(self, "position", target_position, move_duration)


func _create_placeholder_if_needed() -> void:
	if get_node_or_null("MeshInstance3D") == null:
		var mesh_instance := MeshInstance3D.new()
		mesh_instance.name = "MeshInstance3D"
		var box_mesh := BoxMesh.new()
		box_mesh.size = Vector3(3.2, 3.0, 0.45)
		_material = StandardMaterial3D.new()
		box_mesh.material = _material
		mesh_instance.mesh = box_mesh
		add_child(mesh_instance)
	else:
		var existing_mesh_instance := get_node("MeshInstance3D") as MeshInstance3D
		if existing_mesh_instance.mesh != null:
			_material = existing_mesh_instance.mesh.surface_get_material(0) as StandardMaterial3D

	if get_node_or_null("CollisionShape3D") == null:
		var collision := CollisionShape3D.new()
		collision.name = "CollisionShape3D"
		var shape := BoxShape3D.new()
		shape.size = Vector3(3.2, 3.0, 0.45)
		collision.shape = shape
		add_child(collision)


func _update_material() -> void:
	if _material == null:
		return
	_material.albedo_color = Color(0.12, 0.28, 0.26) if is_powered else Color(0.26, 0.08, 0.07)
	_material.emission_enabled = true
	_material.emission = Color(0.05, 0.8, 0.45) if is_powered else Color(0.8, 0.04, 0.02)
	_material.emission_energy_multiplier = 0.8
