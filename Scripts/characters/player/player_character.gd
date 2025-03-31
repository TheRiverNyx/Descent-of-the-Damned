class_name Player extends CharacterBody2D
@export_category("Components")
@export var health:HealthComponent
@export var hitbox:HitboxComponent
@export var hurtbox:HurtBoxComponent
@export var anim_tree:AnimationTree
@export var sprite: FlippableSprite
@export_category("Player Movement")
@export var speed = 300.0
@export var jump_velocity = -400.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	if direction>0:
		sprite.SetFlipH(false)
	elif(direction<0):
		sprite.SetFlipH(true)
	move_and_slide()
