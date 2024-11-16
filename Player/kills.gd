extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.UpdateKills.connect(updateLabel)
	GameManager.resetKills()
func updateLabel(kills:int)->void:
	text=str(kills)
# Called every frame. 'delta' is the elapsed time since the previous frame
