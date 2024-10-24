extends Node3D
@onready var cool_down_timer: Timer = $CoolDownTimer
@export var fire_rate:=14.0
@export var recoil:=0.05
@export var weapon_mesh:Node3D
@export var recoil_speed:=10.0
@onready var weapon_start_position:Vector3=weapon_mesh.position
@onready var ray_cast_3d: RayCast3D = $RayCast3D
@export var weapon_damage:=15
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("fire"):
		if cool_down_timer.is_stopped():
			shoot()
	weapon_mesh.position=weapon_mesh.position.lerp(weapon_start_position,delta*recoil_speed)
	
func shoot():
	cool_down_timer.start(1.0/fire_rate)
	printt("fired",)
	weapon_mesh.position.z+=recoil
	var collider=ray_cast_3d.get_collider()
	if collider is Enemy or collider is Player:
		collider.current_health-=weapon_damage
		
