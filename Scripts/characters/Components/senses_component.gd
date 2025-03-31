extends Node2D
class_name SensesComponent

@export var hearing_area: Area2D
@export var sight_area: Area2D
@export var hearing_shape: CollisionShape2D
@export var left_sight_shape: CollisionPolygon2D
@export var right_sight_shape: CollisionPolygon2D
@export var up_sight_shape: CollisionPolygon2D

var seeing_shape: Array[CollisionPolygon2D] = []

func _ready() -> void:
	# Initialize the sight shape array here (after nodes are ready)
	seeing_shape = [left_sight_shape, right_sight_shape, up_sight_shape]

func change_visible_shape(direction: Vector2) -> void:
	direction = direction.normalized()

	if direction.x > 0.5:
		# Facing right
		set_shape_visibility(right_sight_shape)
	elif direction.x < -0.5:
		# Facing left
		set_shape_visibility(left_sight_shape)
	elif direction.y > 0.5 or direction.y < -0.5:
		# Facing up or down
		set_shape_visibility(up_sight_shape)

	# If you want a default "disable all" when no direction:
	# else:
	#     for shape in seeing_shape:
	#         shape.disabled = true

func get_visible_hostile() -> CharacterBody2D:
	var overlapping_bodies: Array = sight_area.get_overlapping_bodies()
	for body in overlapping_bodies:
		if body is CharacterBody2D:
			return body
	return null

func set_shape_visibility(polygon: CollisionPolygon2D) -> void:
	for shape in seeing_shape:
		shape.disabled = shape != polygon
