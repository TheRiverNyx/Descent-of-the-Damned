extends Sprite2D
class_name FlippableSprite

signal sprite_flipped(new_value:bool)
func SetFlipH(value:bool):
    flip_h = value
    sprite_flipped.emit(value)
