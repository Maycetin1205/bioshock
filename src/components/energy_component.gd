class_name EnergyComponent
extends Node

signal energy_changed(current: float, maximum: float)

@export_range(1.0, 10000.0, 1.0) var max_energy: float = 100.0
@export_range(0.0, 1000.0, 0.1) var regeneration_per_second: float = 8.0
@export_range(0.0, 10.0, 0.1) var regeneration_delay: float = 1.25

var current_energy: float
var _time_since_spend: float = 0.0


func _ready() -> void:
	current_energy = max_energy
	energy_changed.emit(current_energy, max_energy)


func _process(delta: float) -> void:
	_time_since_spend += delta
	if _time_since_spend < regeneration_delay or current_energy >= max_energy:
		return

	current_energy = minf(max_energy, current_energy + regeneration_per_second * delta)
	energy_changed.emit(current_energy, max_energy)


func try_spend(amount: float) -> bool:
	if amount <= 0.0:
		return true
	if current_energy < amount:
		return false

	current_energy -= amount
	_time_since_spend = 0.0
	energy_changed.emit(current_energy, max_energy)
	return true


func restore(amount: float) -> float:
	if amount <= 0.0:
		return 0.0

	var previous := current_energy
	current_energy = minf(max_energy, current_energy + amount)
	energy_changed.emit(current_energy, max_energy)
	return current_energy - previous
