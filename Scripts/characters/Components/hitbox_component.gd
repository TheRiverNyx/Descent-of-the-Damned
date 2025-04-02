extends Area2D

class_name HitboxComponent

@onready var collisionShape: CollisionShape2D = $CollisionShape2D

func _on_sprite_flipped(value: bool) -> void:
    print("signal called")
    match value:
        true:
            collisionShape.scale.x = -1
        false:
            collisionShape.scale.x = 1
