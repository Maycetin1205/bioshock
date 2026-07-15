class_name InteractionRay
extends RayCast3D

@export_range(0.5, 10.0, 0.1) var interaction_distance: float = 3.5
@export_range(1, 8, 1) var parent_search_depth: int = 4

var _actor: Node
var _last_prompt: String = ""


func _ready() -> void:
	target_position = Vector3(0.0, 0.0, -interaction_distance)
	enabled = true
	_actor = _find_player_owner()


func _physics_process(_delta: float) -> void:
	force_raycast_update()
	var interactable := _resolve_interactable(get_collider())
	var prompt := ""

	if interactable != null:
		prompt = str(interactable.call("get_interaction_prompt", _actor))
		if Input.is_action_just_pressed("interact"):
			interactable.call("interact", _actor)

	if prompt != _last_prompt:
		_last_prompt = prompt
		GameEvents.interaction_prompt_changed.emit(prompt)


func _exit_tree() -> void:
	GameEvents.interaction_prompt_changed.emit("")


func _resolve_interactable(candidate: Variant) -> Node:
	if not candidate is Node:
		return null

	var current: Node = candidate
	for _index in range(parent_search_depth + 1):
		if current.has_method("get_interaction_prompt") and current.has_method("interact"):
			return current
		current = current.get_parent()
		if current == null:
			break

	return null


func _find_player_owner() -> Node:
	var current: Node = self
	while current != null:
		if current.is_in_group("player"):
			return current
		current = current.get_parent()
	return null
