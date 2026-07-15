extends Node3D

const PoweredDoorScript := preload("res://src/world/powered_door.gd")
const PowerSwitchScript := preload("res://src/world/power_switch.gd")
const AmmoPickupScript := preload("res://src/world/ammo_pickup.gd")
const EnemyAgentScript := preload("res://src/enemies/enemy_agent.gd")


func _ready() -> void:
	_build_environment()
	_build_room()
	_build_gameplay_objects()
	call_deferred("_announce_objective")


func _build_environment() -> void:
	var world_environment := WorldEnvironment.new()
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color(0.015, 0.035, 0.055)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.10, 0.18, 0.22)
	environment.ambient_light_energy = 0.55
	environment.fog_enabled = true
	environment.fog_light_color = Color(0.04, 0.11, 0.14)
	environment.fog_density = 0.018
	world_environment.environment = environment
	add_child(world_environment)

	var key_light := DirectionalLight3D.new()
	key_light.rotation_degrees = Vector3(-55.0, -25.0, 0.0)
	key_light.light_color = Color(0.35, 0.62, 0.72)
	key_light.light_energy = 0.9
	key_light.shadow_enabled = true
	add_child(key_light)

	for light_position in [Vector3(-6.0, 2.7, 1.0), Vector3(6.0, 2.7, -5.0), Vector3(0.0, 2.7, -10.0)]:
		var light := OmniLight3D.new()
		light.position = light_position
		light.light_color = Color(0.12, 0.65, 0.72)
		light.light_energy = 2.2
		light.omni_range = 7.0
		add_child(light)


func _build_room() -> void:
	_create_static_box("Floor", Vector3(24.0, 0.5, 28.0), Vector3(0.0, -0.25, -4.0), Color(0.09, 0.13, 0.14))
	_create_static_box("Ceiling", Vector3(24.0, 0.4, 28.0), Vector3(0.0, 4.2, -4.0), Color(0.05, 0.07, 0.08))
	_create_static_box("LeftWall", Vector3(0.5, 4.5, 28.0), Vector3(-12.0, 2.0, -4.0), Color(0.08, 0.16, 0.17))
	_create_static_box("RightWall", Vector3(0.5, 4.5, 28.0), Vector3(12.0, 2.0, -4.0), Color(0.08, 0.16, 0.17))
	_create_static_box("FrontWall", Vector3(24.0, 4.5, 0.5), Vector3(0.0, 2.0, 10.0), Color(0.08, 0.16, 0.17))
	_create_static_box("BackWall", Vector3(24.0, 4.5, 0.5), Vector3(0.0, 2.0, -18.0), Color(0.08, 0.16, 0.17))

	_create_static_box("DividerLeft", Vector3(9.8, 4.0, 0.55), Vector3(-7.1, 2.0, -8.0), Color(0.12, 0.18, 0.18))
	_create_static_box("DividerRight", Vector3(9.8, 4.0, 0.55), Vector3(7.1, 2.0, -8.0), Color(0.12, 0.18, 0.18))
	_create_static_box("CoverA", Vector3(2.2, 1.4, 1.4), Vector3(3.0, 0.7, 0.0), Color(0.18, 0.15, 0.10))
	_create_static_box("CoverB", Vector3(1.6, 2.0, 1.6), Vector3(-2.5, 1.0, -3.0), Color(0.14, 0.12, 0.10))
	_create_static_box("RearCover", Vector3(3.0, 1.1, 1.2), Vector3(3.5, 0.55, -12.0), Color(0.16, 0.13, 0.10))

	_create_sign("POWER CONTROL", Vector3(-5.2, 2.0, -4.1))
	_create_sign("SECURITY", Vector3(0.0, 3.5, -7.65))


func _build_gameplay_objects() -> void:
	var door := PoweredDoorScript.new() as PoweredDoor
	door.name = "SecurityDoor"
	door.position = Vector3(0.0, 1.5, -8.0)
	add_child(door)

	var power_switch := PowerSwitchScript.new() as PowerSwitch
	power_switch.name = "PowerSwitch"
	power_switch.position = Vector3(-5.2, 1.0, -4.0)
	add_child(power_switch)
	power_switch.set_power_target(door)

	_spawn_enemy("GuardA", Vector3(5.0, 1.0, -4.5))
	_spawn_enemy("GuardB", Vector3(-3.5, 1.0, -12.0))

	var ammo_pickup := AmmoPickupScript.new() as AmmoPickup
	ammo_pickup.name = "AmmoPickup"
	ammo_pickup.position = Vector3(3.0, 0.25, 1.4)
	ammo_pickup.ammo_amount = 20
	add_child(ammo_pickup)


func _spawn_enemy(enemy_name: String, enemy_position: Vector3) -> void:
	var enemy := EnemyAgentScript.new() as EnemyAgent
	enemy.name = enemy_name
	enemy.position = enemy_position
	add_child(enemy)


func _create_static_box(node_name: String, size: Vector3, box_position: Vector3, color: Color) -> StaticBody3D:
	var body := StaticBody3D.new()
	body.name = node_name
	body.position = box_position

	var mesh_instance := MeshInstance3D.new()
	var mesh := BoxMesh.new()
	mesh.size = size
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	material.metallic = 0.35
	material.roughness = 0.72
	mesh.material = material
	mesh_instance.mesh = mesh
	body.add_child(mesh_instance)

	var collision := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = size
	collision.shape = shape
	body.add_child(collision)

	add_child(body)
	return body


func _create_sign(text: String, sign_position: Vector3) -> void:
	var label := Label3D.new()
	label.text = text
	label.position = sign_position
	label.font_size = 48
	label.modulate = Color(0.3, 0.95, 1.0)
	label.outline_size = 8
	label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	add_child(label)


func _announce_objective() -> void:
	GameEvents.objective_changed.emit("Versorge die Sicherheitstür mit Strom und erreiche den hinteren Raum")
	GameEvents.notification_requested.emit("[LMB] Pistole  [RMB] Elektroimpuls  [R] Nachladen")
