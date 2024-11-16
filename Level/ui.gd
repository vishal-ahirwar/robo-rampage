extends CanvasLayer
@onready var setting: MarginContainer = $Setting
@onready var main: MarginContainer = $Main


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ProjectSettings.settings_changed.connect(settingChanged)

func settingChanged():
	print("setting updated")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_btn_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Level/Level0.tscn")


func _on_btn_setting_pressed() -> void:
	main.visible=false
	setting.visible=true


func _on_btn_about_pressed() -> void:
	pass # Replace with function body.


func _on_btn_quit_pressed() -> void:
	get_tree().quit()


func _on_btn_good_pressed() -> void:
	ProjectSettings.set_setting("rendering/scaling_3d/scale",0.3)
	get_viewport().scaling_3d_scale=ProjectSettings.get_setting("rendering/scaling_3d/scale")

func _on_btn_better_pressed() -> void:
	ProjectSettings.set_setting("rendering/scaling_3d/scale",0.5)
	get_viewport().scaling_3d_scale=ProjectSettings.get_setting("rendering/scaling_3d/scale")

func _on_btn_best_pressed() -> void:
	ProjectSettings.set_setting("rendering/scaling_3d/scale",1.0)
	get_viewport().scaling_3d_scale=ProjectSettings.get_setting("rendering/scaling_3d/scale")


func _on_btn_back_to_menu_pressed() -> void:
	setting.visible=false
	main.visible=true
