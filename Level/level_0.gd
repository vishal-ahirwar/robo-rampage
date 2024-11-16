extends Node3D
@onready var fade_effects: CanvasLayer = $FadeEffects


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fade_effects.fadeOut()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
