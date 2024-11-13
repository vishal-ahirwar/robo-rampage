extends Node3D
@export var sniper: Node3D 
@export var pistol: Node3D


func _ready() -> void:
	equip(sniper)
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("weapon_1"):
		equip(pistol)
	if event.is_action_pressed("weapon_2"):
		equip(sniper)
	if event.is_action_pressed("next_weapon"):
		nextWeapon()
	if event.is_action_pressed("last_weapon"):
		lastWeapon();
		
		
func equip(active_weapon:Node3D)->void:
	for child in get_children():
		if active_weapon == child:
			child.visible=true
			child.set_process(true)
			child.ammo_handler.updateAmmoLabel(child.ammo_type)
		else:
			child.visible=false
			child.set_process(false)

func nextWeapon()->void:
	var index=getCurrentIndex()
	index=wrapi(index+1,0,get_child_count())
	equip(get_child(index))

func getCurrentIndex()->int:
	for index in get_child_count():
		if get_child(index).visible:
			return index
	return 0
	
func lastWeapon():
	var index=getCurrentIndex()
	index=wrapi(index-1,0,get_child_count())
	equip(get_child(index))



func _on_option_button_pressed() -> void:
	nextWeapon()
