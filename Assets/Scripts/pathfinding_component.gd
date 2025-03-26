extends Node2D
class_name PathfindingComponent

@export var nav_agent: NavigationAgent2D
@export var is_pathfinding: bool = true
@export var can_wander: bool = true
@export var wander_radius: float = 100.0
@export var has_home: bool = false
@export var home: Node2D

var next_position: Vector2
var timer: Timer

func _ready() -> void:
	timer = $pathUpdateTimer

func set_target(target: Node2D) -> void:
	var target_position: Vector2 = target.position
	nav_agent.target_position = target_position

func pause_path_update() -> void:
	is_pathfinding = false

func resume_path_update() -> void:
	is_pathfinding = true

func update_path() -> void:
	if not is_pathfinding:
		return

	if nav_agent.is_navigation_finished():
		print("Navigation finished")
	else:
		next_position = nav_agent.get_next_path_position()
		print("Moving to ", next_position)

func set_home(new_home: Node2D) -> void:
	home = new_home

func set_home_as_target() -> void:
	has_home = true
	set_target(home)

func set_wander_point() -> void:
	if not is_pathfinding or not can_wander:
		return
	# TODO: Implement wander logic (random point within radius)
