extends CharacterBody3D
class_name Enemy

@onready var audio_stream_player: AudioStreamPlayer = $death_sound
@onready var fire: AudioStreamPlayer = $fire

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
var player
var provoked:=false
@export var aggro_range:=12.0
@export var attack_range:=6.5
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var max_health:=100
@onready var ray_cast_3d: RayCast3D = $RayCast3D
@export var damage:=5
var current_health:=max_health:
	set(value):
		current_health=value
		if current_health<=0:
			if not audio_stream_player.playing:
				animation_player.play("dead")
				audio_stream_player.play()
		provoked=true

func _ready() -> void:
	player=get_tree().get_first_node_in_group("player")

func _process(_delta: float) -> void:
	if(provoked):
		navigation_agent_3d.target_position=player.global_position
	
func _physics_process(delta: float) -> void:
	if not player:
		return
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
		if distance<=attack_range and current_health>0:
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
	if position==global_position+adjusted_direction:
		return
	look_at(global_position+adjusted_direction,Vector3.UP,true)
	

func attack()->void:
	fire.play()
	var collider=ray_cast_3d.get_collider()
	if collider is Player:
		collider.current_health-=damage
		
