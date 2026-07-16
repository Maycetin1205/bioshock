extends Node

const SCREENSHOT_ARGUMENT := "--capture-screenshot"
const OUTPUT_PATH := "user://abyssal_protocol_preview.png"


func _ready() -> void:
	if SCREENSHOT_ARGUMENT not in OS.get_cmdline_user_args():
		return
	capture.call_deferred()


func capture() -> void:
	await get_tree().create_timer(1.5).timeout
	var player := get_tree().get_first_node_in_group("player") as Node3D
	if player != null:
		player.global_position = Vector3(0.0, 1.0, 7.0)
		player.global_rotation = Vector3.ZERO
		var head := player.get_node_or_null("Head") as Node3D
		if head != null:
			head.rotation = Vector3(deg_to_rad(-4.0), 0.0, 0.0)
	await get_tree().process_frame
	await get_tree().process_frame
	await RenderingServer.frame_post_draw
	var image := get_viewport().get_texture().get_image()
	var error := image.save_png(OUTPUT_PATH)
	if error != OK:
		push_error("Could not save screenshot: %s" % error_string(error))
		get_tree().quit(1)
		return
	print("SCREENSHOT_PATH=%s" % ProjectSettings.globalize_path(OUTPUT_PATH))
	get_tree().quit()
