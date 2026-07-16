class_name HealthComponent
extends Node

signal health_changed(current: float, maximum: float)
signal died(source: Variant)

@export_range(1.0, 10000.0, 1.0) var max_health: float = 100.0

var current_health: float


func _ready() -> void:
	current_health = max_health
	health_changed.emit(current_health, max_health)


func damage(amount: float, source: Variant = null) -> float:
	if amount <= 0.0 or current_health <= 0.0:
		return 0.0

	var previous := current_health
	current_health = maxf(0.0, current_health - amount)
	health_changed.emit(current_health, max_health)

	if is_zero_approx(current_health):
		died.emit(source)

	return previous - current_health


func heal(amount: float) -> float:
	if amount <= 0.0 or current_health <= 0.0:
		return 0.0

	var previous := current_health
	current_health = minf(max_health, current_health + amount)
	health_changed.emit(current_health, max_health)
	return current_health - previous


func reset() -> void:
	current_health = max_health
	health_changed.emit(current_health, max_health)
