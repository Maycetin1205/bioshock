class_name GameHUD
extends CanvasLayer

@onready var health_label: Label = %HealthLabel
@onready var energy_label: Label = %EnergyLabel
@onready var prompt_label: Label = %PromptLabel
@onready var objective_label: Label = %ObjectiveLabel
@onready var notification_label: Label = %NotificationLabel

var _notification_tween: Tween


func _ready() -> void:
	GameEvents.player_health_changed.connect(_on_health_changed)
	GameEvents.player_energy_changed.connect(_on_energy_changed)
	GameEvents.interaction_prompt_changed.connect(_on_prompt_changed)
	GameEvents.objective_changed.connect(_on_objective_changed)
	GameEvents.notification_requested.connect(_on_notification_requested)

	_on_health_changed(100.0, 100.0)
	_on_energy_changed(100.0, 100.0)
	_on_prompt_changed("")
	_on_objective_changed("Versorge die Sicherheitstür mit Strom")


func _on_health_changed(current: float, maximum: float) -> void:
	health_label.text = "GESUNDHEIT  %d / %d" % [roundi(current), roundi(maximum)]


func _on_energy_changed(current: float, maximum: float) -> void:
	energy_label.text = "ENERGIE     %d / %d" % [roundi(current), roundi(maximum)]


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
