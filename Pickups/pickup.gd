extends Area3D
@export var ammo_type:AmmoHandler.AmmoType
@export var ammo_amount:int

func _on_body_entered(body: Node3D) -> void:
	print(body)
	if body.is_in_group("player"):
		body.ammo_handler.addAmmo(ammo_type,ammo_amount)
		queue_free()
		
func _ready() -> void:
	body_entered.connect(_on_body_entered)
