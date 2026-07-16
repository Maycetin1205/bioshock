class_name PowerSwitch
extends StaticBody3D

var is_active: bool = false
var _power_target: Node
var _material: StandardMaterial3D


func _ready() -> void:
	_create_placeholder_if_needed()
	_update_material()


func set_power_target(target: Node) -> void:
	_power_target = target
	_apply_power_state()


func get_interaction_prompt(_actor: Node) -> String:
	return "Stromkreis ausschalten" if is_active else "Stromkreis einschalten"


func interact(_actor: Node) -> void:
	set_active(not is_active)


func apply_electric_hit(_damage: float, _stun_duration: float, _source: Variant = null) -> void:
	set_active(true)
	GameEvents.notification_requested.emit("Stromkreis elektrisch aktiviert")


func set_active(value: bool) -> void:
	if value == is_active:
		return
	is_active = value
	_apply_power_state()
	_update_material()

	if is_active:
		GameEvents.objective_changed.emit("Öffne die jetzt versorgte Sicherheitstür")
	else:
		GameEvents.objective_changed.emit("Versorge die Sicherheitstür mit Strom")


func _apply_power_state() -> void:
	if _power_target != null and _power_target.has_method("set_powered"):
		_power_target.call("set_powered", is_active)


func _create_placeholder_if_needed() -> void:
	var mesh_instance := MeshInstance3D.new()
	mesh_instance.name = "MeshInstance3D"
	var box_mesh := BoxMesh.new()
	box_mesh.size = Vector3(0.7, 1.0, 0.35)
	_material = StandardMaterial3D.new()
	box_mesh.material = _material
	mesh_instance.mesh = box_mesh
	add_child(mesh_instance)

	var collision := CollisionShape3D.new()
	collision.name = "CollisionShape3D"
	var shape := BoxShape3D.new()
	shape.size = Vector3(0.7, 1.0, 0.35)
	collision.shape = shape
	add_child(collision)


func _update_material() -> void:
	if _material == null:
		return
	_material.albedo_color = Color(0.08, 0.42, 0.22) if is_active else Color(0.38, 0.10, 0.06)
	_material.emission_enabled = true
	_material.emission = Color(0.1, 1.0, 0.35) if is_active else Color(1.0, 0.12, 0.03)
	_material.emission_energy_multiplier = 1.4
