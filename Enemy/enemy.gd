extends CharacterBody3D
class_name Enemy
@onready var pistol: Node3D = $Pistol

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
var player
var provoked:=false
@export var aggro_range:=12.0
@export var attack_range:=6.5
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var max_health:=100
var current_health:=max_health:
	set(value):
		current_health=value
		if current_health<=0:
			queue_free()
		provoked=true

func _ready() -> void:
	player=get_tree().get_first_node_in_group("player")

func _process(delta: float) -> void:
	if(provoked):
		navigation_agent_3d.target_position=player.global_position
	
func _physics_process(delta: float) -> void:
	var next_position=navigation_agent_3d.get_next_path_position()
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var direction=global_position.direction_to(next_position)
	var distance=global_position.distance_to(player.global_position)
	if(distance<aggro_range):
		provoked=true
	else:
		provoked=false
	if(provoked):
		if distance<=attack_range:
			if not animation_player.is_playing():
				animation_player.play("Attack")
			
	if direction:
		lookAtTarget(direction)
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func lookAtTarget(direction:Vector3)->void:
	var adjusted_direction=direction
	adjusted_direction.y=0
	if global_position==adjusted_direction:
		return
	look_at(global_position+adjusted_direction,Vector3.UP,true)
	

func attack()->void:
	pistol.shoot()
