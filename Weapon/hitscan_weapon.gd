extends Node3D
@onready var cool_down_timer: Timer = $CoolDownTimer
@export var fire_rate:=14.0
@export var recoil:=0.05
@export var weapon_mesh:Node3D
@export var muzzle_flash:GPUParticles3D
@export var sparks:=preload("res://Weapon/ParticleEffects/sparks.tscn")
@export var recoil_speed:=10.0
@onready var weapon_start_position:Vector3=weapon_mesh.position
@onready var ray_cast_3d: RayCast3D = $RayCast3D
@export var weapon_damage:=15
@export var fire_sound:AudioStreamPlayer
@export var is_shotgun:bool
@export var is_pistol:bool
@export var ammo_handler:AmmoHandler
@export var ammo_type:AmmoHandler.AmmoType
@export var animation_player:AnimationPlayer
var can_shoot:=true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if not weapon_enabled:
		#print("weapon is not enabled")
		#return
	if Input.is_action_pressed("fire"):
		
		if is_pistol or is_shotgun:
			if cool_down_timer.is_stopped() and can_shoot:
				shoot()
		else:
			if cool_down_timer.is_stopped():
				shoot()
		can_shoot=false
		
	weapon_mesh.position=weapon_mesh.position.lerp(weapon_start_position,delta*recoil_speed)
	if Input.is_action_just_released("fire") and is_pistol or is_shotgun:
		can_shoot=true
	
func shoot():
	if ammo_handler.hasAmmo(ammo_type):
		ammo_handler.useAmmo(ammo_type)
		muzzle_flash.restart()
		cool_down_timer.start(1.0/fire_rate)
		fire_sound.play()
		weapon_mesh.position.z+=recoil
		var collider=ray_cast_3d.get_collider()
		if ray_cast_3d.get_collider():
			spawnSparks()
		if collider is Enemy or collider is Player: 
			collider.current_health-=weapon_damage
		

func spawnSparks():
	var spark=sparks.instantiate()
	spark.global_position=ray_cast_3d.get_collision_point()
	add_child(spark)
	
func _on_visibility_changed() -> void:
	if visible:
		animation_player.play("on_equip")
