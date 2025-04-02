class_name Player extends CharacterBody2D
@export_category("Components")
@export var health:HealthComponent
@export var hitbox:HitboxComponent
@export var hurtbox:HurtBoxComponent
@export var animation_player:AnimationPlayer
@export var sprite: FlippableSprite
@export_category("Player Movement")
@export var speed = 300.0
@export var jump_velocity = -400.0
var gravity:Vector2
@export var current_state: PlayerStates = PlayerStates.IDLE

enum PlayerStates{
    WALKING,
    RUNNING,
    JUMPING,
    FALLING,
    IDLE,
    ATTACKING,
    DODGING
}
func _ready() -> void:
    gravity = get_gravity()

func _physics_process(delta: float) -> void:
    # Add the gravity.
    if not is_on_floor():
        current_state=PlayerStates.FALLING
        velocity += get_gravity() * delta

    # Handle jump.
    if Input.is_action_just_pressed("jump") and is_on_floor():
        jump()

    # Get the input direction and handle the movement/deceleration.
    # As good practice, you should replace UI actions with custom gameplay actions.
    var direction := Input.get_axis("move_left", "move_right")
    if direction:
        velocity.x = direction * speed
        current_state=PlayerStates.RUNNING
    else:
        velocity.x = move_toward(velocity.x, 0, speed)
    move_and_slide()
    if is_zero_approx(velocity.x) and is_on_floor():
        current_state=PlayerStates.IDLE
    
func jump()-> void:
    current_state = PlayerStates.JUMPING
    velocity.y = jump_velocity
