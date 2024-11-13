extends Node
class_name AmmoHandler
@export var ammo_label:Label
enum AmmoType {
	PISTOL_BULLET,
	SNIPER_BULLET
}

var ammo_storage:= {
	AmmoType.PISTOL_BULLET:12,
	AmmoType.SNIPER_BULLET:5
}

func hasAmmo(type:AmmoType)->bool:
	return ammo_storage[type]>0

func useAmmo(type:AmmoType)->void:
	if hasAmmo(type):
		ammo_storage[type]-=1
		updateAmmoLabel(type)

func updateAmmoLabel(type:AmmoType):
	ammo_label.text=str(ammo_storage[type])

func addAmmo(type:AmmoType,ammo:int):
	ammo_storage[type]+=ammo
