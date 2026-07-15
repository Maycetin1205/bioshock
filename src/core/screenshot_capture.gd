extends Node

const SCREENSHOT_ARGUMENT := "--capture-screenshot"
const OUTPUT_PATH := "user://abyssal_protocol_preview.png"

func _ready() -> void:
	if SCREENSHOT_ARGUMENT not in OS.get_cmdline_user_args():
		return
	capture.call_deferred()

func capture() -> void:
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().create_timer(0.5).timeout
	var image := get_viewport().get_texture().get_image()
	var error := image.save_png(OUTPUT_PATH)
	if error != OK:
		push_error("Could not save screenshot: %s" % error_string(error))
		get_tree().quit(1)
		return
	print("SCREENSHOT_PATH=%s" % ProjectSettings.globalize_path(OUTPUT_PATH))
	get_tree().quit()
