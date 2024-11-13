extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if OS.get_name()=="Android" or OS.get_name()=="iOS":
		visible=true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
