extends Node2D
class_name FlippableComponent

var children

func _ready() -> void:
    children=get_children()
func flip(value:bool):
    match value:
        true:
            for child in children:
                child.scale.x = -1
        false:
            for child in children:
                child.scale.x = 1
