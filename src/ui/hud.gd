class_name GameHUD
extends CanvasLayer

@onready var health_label: Label = %HealthLabel
@onready var energy_label: Label = %EnergyLabel
@onready var ammo_label: Label = %AmmoLabel
@onready var prompt_label: Label = %PromptLabel
@onready var objective_label: Label = %ObjectiveLabel
@onready var notification_label: Label = %NotificationLabel
@onready var crosshair_label: Label = %Crosshair

var _notification_tween: Tween
var _hit_tween: Tween
var _ammo_in_magazine: int = 8
var _reserve_ammo: int = 32
var _is_reloading: bool = false


func _ready() -> void:
	GameEvents.player_health_changed.connect(_on_health_changed)
	GameEvents.player_energy_changed.connect(_on_energy_changed)
	GameEvents.weapon_ammo_changed.connect(_on_ammo_changed)
	GameEvents.weapon_reload_changed.connect(_on_reload_changed)
	GameEvents.hit_confirmed.connect(_on_hit_confirmed)
	GameEvents.interaction_prompt_changed.connect(_on_prompt_changed)
	GameEvents.objective_changed.connect(_on_objective_changed)
	GameEvents.notification_requested.connect(_on_notification_requested)

	_on_health_changed(100.0, 100.0)
	_on_energy_changed(100.0, 100.0)
	_refresh_ammo_label()
	_on_prompt_changed("")
	_on_objective_changed("Versorge die Sicherheitstür mit Strom")


func _on_health_changed(current: float, maximum: float) -> void:
	health_label.text = "GESUNDHEIT  %d / %d" % [roundi(current), roundi(maximum)]


func _on_energy_changed(current: float, maximum: float) -> void:
	energy_label.text = "ENERGIE     %d / %d" % [roundi(current), roundi(maximum)]


func _on_ammo_changed(in_magazine: int, reserve: int) -> void:
	_ammo_in_magazine = in_magazine
	_reserve_ammo = reserve
	_refresh_ammo_label()


func _on_reload_changed(is_reloading: bool) -> void:
	_is_reloading = is_reloading
	_refresh_ammo_label()


func _refresh_ammo_label() -> void:
	var suffix := "  NACHLADEN ..." if _is_reloading else ""
	ammo_label.text = "MUNITION    %d / %d%s" % [_ammo_in_magazine, _reserve_ammo, suffix]


func _on_hit_confirmed(_applied_damage: float) -> void:
	if _hit_tween != null:
		_hit_tween.kill()
	crosshair_label.text = "×"
	_hit_tween = create_tween()
	_hit_tween.tween_interval(0.12)
	_hit_tween.tween_callback(_reset_crosshair)


func _reset_crosshair() -> void:
	crosshair_label.text = "+"


func _on_prompt_changed(text: String) -> void:
	prompt_label.text = "[E] %s" % text if not text.is_empty() else ""


func _on_objective_changed(text: String) -> void:
	objective_label.text = "ZIEL\n%s" % text


func _on_notification_requested(text: String) -> void:
	if _notification_tween != null:
		_notification_tween.kill()

	notification_label.text = text
	notification_label.modulate.a = 1.0
	_notification_tween = create_tween()
	_notification_tween.tween_interval(1.4)
	_notification_tween.tween_property(notification_label, "modulate:a", 0.0, 0.5)
