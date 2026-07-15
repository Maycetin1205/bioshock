class_name PlayerController
extends CharacterBody3D

@export_range(0.1, 20.0, 0.1) var walk_speed: float = 5.0
@export_range(0.1, 30.0, 0.1) var sprint_speed: float = 8.0
@export_range(1.0, 100.0, 0.5) var acceleration: float = 22.0
@export_range(0.001, 0.02, 0.0005) var mouse_sensitivity: float = 0.0025
@export_range(1.0, 15.0, 0.1) var jump_velocity: float = 5.0
@export_range(45.0, 89.0, 1.0) var vertical_look_limit_degrees: float = 85.0

@onready var head: Node3D = $Head
@onready var health_component: HealthComponent = $HealthComponent
@onready var energy_component: EnergyComponent = $EnergyComponent

var _gravity: float = float(ProjectSettings.get_setting("physics/3d/default_gravity", 9.8))


func _ready() -> void:
	add_to_group("player")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	health_component.health_changed.connect(_on_health_changed)
	health_component.died.connect(_on_died)
	energy_component.energy_changed.connect(_on_energy_changed)

	_on_health_changed(health_component.current_health, health_component.max_health)
	_on_energy_changed(energy_component.current_energy, energy_component.max_energy)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		head.rotate_x(-event.relative.y * mouse_sensitivity)
		head.rotation.x = clampf(
			head.rotation.x,
			deg_to_rad(-vertical_look_limit_degrees),
			deg_to_rad(vertical_look_limit_degrees)
		)


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= _gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	var input_vector := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var desired_direction := (global_transform.basis * Vector3(input_vector.x, 0.0, input_vector.y)).normalized()
	var target_speed := sprint_speed if Input.is_action_pressed("sprint") else walk_speed
	var target_velocity := desired_direction * target_speed

	velocity.x = move_toward(velocity.x, target_velocity.x, acceleration * delta)
	velocity.z = move_toward(velocity.z, target_velocity.z, acceleration * delta)
	move_and_slide()


func apply_damage(amount: float, source: Variant = null) -> float:
	return health_component.damage(amount, source)


func restore_health(amount: float) -> float:
	return health_component.heal(amount)


func restore_energy(amount: float) -> float:
	return energy_component.restore(amount)


func _on_health_changed(current: float, maximum: float) -> void:
	GameEvents.player_health_changed.emit(current, maximum)


func _on_energy_changed(current: float, maximum: float) -> void:
	GameEvents.player_energy_changed.emit(current, maximum)


func _on_died(_source: Variant) -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	GameEvents.notification_requested.emit("Du wurdest ausgeschaltet. Neustart ...")
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()
