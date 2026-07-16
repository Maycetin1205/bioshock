class_name AmmoPickup
extends StaticBody3D

@export_range(1, 200, 1) var ammo_amount: int = 16

var _collected: bool = false


func _ready() -> void:
	add_to_group("interactables")
	_create_placeholder_if_needed()


func get_interaction_prompt(_actor: Node) -> String:
	return "Munition aufnehmen (+%d)" % ammo_amount


func interact(actor: Node) -> void:
	if _collected or actor == null or not actor.has_method("add_ammo"):
		return

	var accepted := int(actor.call("add_ammo", ammo_amount))
	if accepted <= 0:
		GameEvents.notification_requested.emit("Munitionsreserve voll")
		return

	_collected = true
	GameEvents.notification_requested.emit("%d Schuss aufgenommen" % accepted)
	queue_free()


func _create_placeholder_if_needed() -> void:
	if get_node_or_null("MeshInstance3D") != null:
		return

	var mesh_instance := MeshInstance3D.new()
	mesh_instance.name = "MeshInstance3D"
	var mesh := BoxMesh.new()
	mesh.size = Vector3(0.55, 0.25, 0.4)
	var material := StandardMaterial3D.new()
	material.albedo_color = Color(0.48, 0.30, 0.10)
	material.metallic = 0.45
	material.roughness = 0.55
	mesh.material = material
	mesh_instance.mesh = mesh
	add_child(mesh_instance)

	var collision := CollisionShape3D.new()
	collision.name = "CollisionShape3D"
	var shape := BoxShape3D.new()
	shape.size = mesh.size
	collision.shape = shape
	add_child(collision)
