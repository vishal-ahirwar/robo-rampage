extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_btn_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Level/Level0.tscn")


func _on_btn_setting_pressed() -> void:
	pass # Replace with function body.


func _on_btn_about_pressed() -> void:
	pass # Replace with function body.


func _on_btn_quit_pressed() -> void:
	pass # Replace with function body.
