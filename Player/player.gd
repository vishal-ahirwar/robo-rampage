extends CharacterBody3D
class_name Player
@export
var mouse_senstivity:=0.4
@export var camera_pivot:Node3D
const SPEED = 5.0
@export var jump_height:=1.0
@export var fall_multiplier:=4.4
var gravity:float=ProjectSettings.get_setting("physics/3d/default_gravity")
var mouse_motion:=Vector2.ZERO
var menu
@onready var animationplay_damage: AnimationPlayer = $AnimationplayDamage
@onready var game_over_menu: Control = $GameOverMenu

@export var max_health:int
@onready var ammo_handler: AmmoHandler = $CamerPivot/Camera3D/AmmoHandler
@onready var camera_3d: Camera3D = $CamerPivot/Camera3D
@onready var fov:=camera_3d.fov
@export var aim_multiplayer:=0.7
@export var health:Label
@onready var current_health:=max_health:
	set(value):
		if value<current_health:
			animationplay_damage.stop(false)	
			animationplay_damage.play("damage_dealt")
		current_health=value
		updateHealthLabel(current_health)
		if current_health<=0:
			game_over_menu.gameOver()
			
func _ready() -> void:
	Input.mouse_mode=Input.MOUSE_MODE_CAPTURED
	updateHealthLabel(current_health)
func updateHealthLabel(new_health:int):
	health.text=str(new_health)
	
func _process(delta: float) -> void:
	if Input.is_action_pressed("aim"):
		camera_3d.fov=lerp(camera_3d.fov,fov*aim_multiplayer,delta*20)
	else:
		camera_3d.fov=lerp(camera_3d.fov,fov,delta*20)
func _physics_process(delta: float) -> void:
	# Add the gravity.
	handleMouseMotion(delta)
	if not is_on_floor():
		if velocity.y>=0:
			velocity += get_gravity() * delta
		else:
			velocity += get_gravity() * delta*fall_multiplier
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = sqrt(jump_height*2*gravity)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		if Input.is_action_pressed("aim"):
			velocity.x*=aim_multiplayer
			velocity.z*=aim_multiplayer
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode==Input.MOUSE_MODE_CAPTURED:
		mouse_motion=-event.relative*mouse_senstivity
		if Input.is_action_pressed("aim"):
			mouse_motion*=aim_multiplayer
	if event is InputEventScreenDrag:
		mouse_motion=-event.relative*mouse_senstivity
		if Input.is_action_pressed("aim"):
			mouse_motion*=aim_multiplayer
	if event.is_action_pressed("menu"):
		if menu:
			remove_child(menu)
			Input.mouse_mode=Input.MOUSE_MODE_CAPTURED
			menu=null
		else:
			Input.mouse_mode=Input.MOUSE_MODE_VISIBLE
		
func handleMouseMotion(delta:float)->void:
	rotate_y(delta*mouse_motion.x)
	camera_pivot.rotate_x(delta*mouse_motion.y)
	camera_pivot.rotation_degrees.x=clampf(camera_pivot.rotation_degrees.x,-90,65)
	mouse_motion=Vector2.ZERO


func _on_touch_screen_button_pressed() -> void:
	Input.action_press("fire")


func _on_scope_released() -> void:
	Input.action_release("aim")


func _on_scope_pressed() -> void:
	Input.action_press("aim")


func _on_jump_pressed() -> void:
	Input.action_press("jump")
