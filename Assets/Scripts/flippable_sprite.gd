extends Sprite2D
class_name FlippableSprite

signal SpriteFlipped
func SetFlipH(value:bool):
	flip_h = value
	emit_signal("SpriteFlipped",value)
