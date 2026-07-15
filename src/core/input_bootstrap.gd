extends Node

const KEY_ACTIONS := {
	"move_forward": [KEY_W, KEY_UP],
	"move_backward": [KEY_S, KEY_DOWN],
	"move_left": [KEY_A, KEY_LEFT],
	"move_right": [KEY_D, KEY_RIGHT],
	"sprint": [KEY_SHIFT],
	"jump": [KEY_SPACE],
	"interact": [KEY_E],
	"toggle_mouse_capture": [KEY_ESCAPE],
}

const MOUSE_ACTIONS := {
	"ability_primary": [MOUSE_BUTTON_LEFT],
}


func _ready() -> void:
	for action_name in KEY_ACTIONS:
		_ensure_action(action_name)
		for keycode in KEY_ACTIONS[action_name]:
			_ensure_key_binding(action_name, keycode)

	for action_name in MOUSE_ACTIONS:
		_ensure_action(action_name)
		for button_index in MOUSE_ACTIONS[action_name]:
			_ensure_mouse_binding(action_name, button_index)


func _ensure_action(action_name: StringName) -> void:
	if not InputMap.has_action(action_name):
		InputMap.add_action(action_name)


func _ensure_key_binding(action_name: StringName, keycode: Key) -> void:
	for existing_event in InputMap.action_get_events(action_name):
		if existing_event is InputEventKey and existing_event.physical_keycode == keycode:
			return

	var event := InputEventKey.new()
	event.physical_keycode = keycode
	InputMap.action_add_event(action_name, event)


func _ensure_mouse_binding(action_name: StringName, button_index: MouseButton) -> void:
	for existing_event in InputMap.action_get_events(action_name):
		if existing_event is InputEventMouseButton and existing_event.button_index == button_index:
			return

	var event := InputEventMouseButton.new()
	event.button_index = button_index
	InputMap.action_add_event(action_name, event)
