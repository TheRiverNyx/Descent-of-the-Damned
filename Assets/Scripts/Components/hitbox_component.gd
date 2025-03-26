extends Area2D

class_name HitboxComponent


func _on_sprite_flipped(value: bool) -> void:
	match value:
		true:
			scale.x=-1
		false:
			scale.x =1
