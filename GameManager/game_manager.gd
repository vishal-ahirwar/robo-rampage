extends Node
signal UpdateKills(kills:int)

var _kills:=0

func addKill()->void:
	_kills+=1
	UpdateKills.emit(_kills)

func resetKills()->void:
	_kills=0
	UpdateKills.emit(_kills)

func _init() -> void:
	if OS.get_name()=="Android":
		ProjectSettings.set_setting("rendering/scaling_3d/scale",0.7)
