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
	environment.background_color = Color(0.008, 0.018, 0.028)
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color(0.18, 0.26, 0.30)
	environment.ambient_light_energy = 1.15
	environment.fog_enabled = true
	environment.fog_light_color = Color(0.05, 0.13, 0.16)
	environment.fog_density = 0.008
	world_environment.environment = environment
	add_child(world_environment)
	var key_light := DirectionalLight3D.new()
	key_light.rotation_degrees = Vector3(-58.0, -18.0, 0.0)
	key_light.light_color = Color(0.45, 0.72, 0.82)
	key_light.light_energy = 1.45
	key_light.shadow_enabled = true
	add_child(key_light)
	_create_omni_light(Vector3(-5.5, 2.8, 3.0), Color(0.1, 0.75, 0.88), 5.0, 9.0)
	_create_omni_light(Vector3(5.5, 2.8, -2.0), Color(0.95, 0.42, 0.16), 4.2, 8.0)
	_create_omni_light(Vector3(0.0, 3.0, -7.0), Color(0.12, 0.72, 0.84), 5.5, 9.0)
	_create_omni_light(Vector3(-3.5, 2.7, -13.0), Color(0.8, 0.18, 0.12), 3.8, 7.0)


func _build_room() -> void:
	_create_static_box("Floor", Vector3(24.0, 0.5, 28.0), Vector3(0.0, -0.25, -4.0), Color(0.08, 0.12, 0.13))
	_create_static_box("Ceiling", Vector3(24.0, 0.4, 28.0), Vector3(0.0, 4.2, -4.0), Color(0.04, 0.055, 0.065))
	_create_static_box("LeftWall", Vector3(0.5, 4.5, 28.0), Vector3(-12.0, 2.0, -4.0), Color(0.07, 0.15, 0.16))
	_create_static_box("RightWall", Vector3(0.5, 4.5, 28.0), Vector3(12.0, 2.0, -4.0), Color(0.07, 0.15, 0.16))
	_create_static_box("FrontWall", Vector3(24.0, 4.5, 0.5), Vector3(0.0, 2.0, 10.0), Color(0.07, 0.15, 0.16))
	_create_static_box("BackWall", Vector3(24.0, 4.5, 0.5), Vector3(0.0, 2.0, -18.0), Color(0.07, 0.15, 0.16))
	_create_static_box("DividerLeft", Vector3(9.8, 4.0, 0.55), Vector3(-7.1, 2.0, -8.0), Color(0.11, 0.18, 0.18))
	_create_static_box("DividerRight", Vector3(9.8, 4.0, 0.55), Vector3(7.1, 2.0, -8.0), Color(0.11, 0.18, 0.18))
	_create_static_box("CoverA", Vector3(2.2, 1.4, 1.4), Vector3(3.0, 0.7, 0.0), Color(0.22, 0.16, 0.08))
	_create_static_box("CoverB", Vector3(1.6, 2.0, 1.6), Vector3(-2.5, 1.0, -3.0), Color(0.16, 0.11, 0.07))
	_create_static_box("RearCover", Vector3(3.0, 1.1, 1.2), Vector3(3.5, 0.55, -12.0), Color(0.18, 0.12, 0.07))
	_create_emissive_panel(Vector3(0.0, 0.015, 3.0), Vector3(0.28, 0.03, 12.0), Color(0.04, 0.78, 0.92))
	_create_emissive_panel(Vector3(-11.72, 2.2, -1.0), Vector3(0.04, 0.35, 11.0), Color(0.02, 0.55, 0.66))
	_create_emissive_panel(Vector3(11.72, 2.2, -7.0), Vector3(0.04, 0.35, 11.0), Color(0.65, 0.18, 0.05))
	for z_position in [5.0, 1.0, -3.0, -7.0, -11.0, -15.0]:
		_create_pipe(Vector3(-9.8, 3.25, z_position), Vector3(0.0, 0.0, 90.0), Color(0.13, 0.32, 0.34))
		_create_pipe(Vector3(9.8, 3.25, z_position), Vector3(0.0, 0.0, 90.0), Color(0.28, 0.14, 0.08))
	_create_sign("POWER CONTROL", Vector3(-5.2, 2.0, -4.1), Color(0.25, 0.95, 1.0))
	_create_sign("SECURITY BULKHEAD", Vector3(0.0, 3.45, -7.65), Color(0.25, 0.95, 1.0))
	_create_sign("SECTOR 03", Vector3(4.8, 2.8, 2.5), Color(1.0, 0.46, 0.16))


func _build_gameplay_objects() -> void:
	var door = PoweredDoorScript.new()
	door.name = "SecurityDoor"
	door.position = Vector3(0.0, 1.5, -8.0)
	add_child(door)
	var power_switch = PowerSwitchScript.new()
	power_switch.name = "PowerSwitch"
	power_switch.position = Vector3(-5.2, 1.0, -4.0)
	add_child(power_switch)
	power_switch.set_power_target(door)
	_spawn_enemy("GuardA", Vector3(5.0, 1.0, -4.5))
	_spawn_enemy("GuardB", Vector3(-3.5, 1.0, -12.0))
	var ammo_pickup = AmmoPickupScript.new()
	ammo_pickup.name = "AmmoPickup"
	ammo_pickup.position = Vector3(3.0, 0.25, 1.4)
	ammo_pickup.ammo_amount = 20
	add_child(ammo_pickup)


func _spawn_enemy(enemy_name: String, enemy_position: Vector3) -> void:
	var enemy = EnemyAgentScript.new()
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
	material.metallic = 0.4
	material.roughness = 0.66
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


func _create_emissive_panel(panel_position: Vector3, size: Vector3, color: Color) -> void:
	var mesh_instance := MeshInstance3D.new()
	mesh_instance.position = panel_position
	var mesh := BoxMesh.new()
	mesh.size = size
	var material := StandardMaterial3D.new()
	material.albedo_color = color * 0.35
	material.emission_enabled = true
	material.emission = color
	material.emission_energy_multiplier = 4.0
	mesh.material = material
	mesh_instance.mesh = mesh
	add_child(mesh_instance)


func _create_pipe(pipe_position: Vector3, pipe_rotation: Vector3, color: Color) -> void:
	var mesh_instance := MeshInstance3D.new()
	mesh_instance.position = pipe_position
	mesh_instance.rotation_degrees = pipe_rotation
	var mesh := CylinderMesh.new()
	mesh.top_radius = 0.16
	mesh.bottom_radius = 0.16
	mesh.height = 3.4
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	material.metallic = 0.72
	material.roughness = 0.35
	mesh.material = material
	mesh_instance.mesh = mesh
	add_child(mesh_instance)


func _create_omni_light(light_position: Vector3, color: Color, energy: float, light_range: float) -> void:
	var light := OmniLight3D.new()
	light.position = light_position
	light.light_color = color
	light.light_energy = energy
	light.omni_range = light_range
	light.shadow_enabled = true
	add_child(light)


func _create_sign(text: String, sign_position: Vector3, color: Color) -> void:
	var label := Label3D.new()
	label.text = text
	label.position = sign_position
	label.font_size = 48
	label.modulate = color
	label.outline_size = 8
	label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	add_child(label)


func _announce_objective() -> void:
	GameEvents.objective_changed.emit("Versorge die Sicherheitstür mit Strom und erreiche den hinteren Raum")
	GameEvents.notification_requested.emit("[LMB] Pistole  [RMB] Elektroimpuls  [R] Nachladen")
