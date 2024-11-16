extends Control
#@onready var fade_effects: MarginContainer = $FadeEffects
@onready var fade_effects: CanvasLayer = $FadeEffects

func gameOver()->void:
	visible=true
	fade_effects.fadeIn()
	Input.mouse_mode=Input.MOUSE_MODE_VISIBLE
	get_tree().paused=true
# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_btn_try_again_pressed() -> void:
	get_tree().paused=false
	get_tree().reload_current_scene() # Replace with function body.


func _on_btn_gave_up_pressed() -> void:
	get_tree().quit()


func _on_btn_menu_pressed() -> void:
	get_tree().paused=false
	get_tree().change_scene_to_file("res://Level/MainMenu.tscn")
