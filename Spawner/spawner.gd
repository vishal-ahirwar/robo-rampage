extends Node3D
@onready var spawn_timer: Timer = $SpawnTimer
@export var enemy:PackedScene
@export var spawn_points:Array[Marker3D]
@export var spawn_delay:int

func _ready() -> void:
	spawn_timer.wait_time=spawn_delay
	spawn_timer.timeout.connect(spawn)
	
func spawn():
	var localtion=spawn_points.pick_random().position
	var new_enemy=enemy.instantiate()
	new_enemy.position=localtion
	add_child(new_enemy)
