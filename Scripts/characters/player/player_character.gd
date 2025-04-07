class_name Player extends CharacterBody2D
@export_category("Components")
@export var health:HealthComponent
@export var hitbox:HitboxComponent 
@export var hurtbox:HurtBoxComponent
@export var animation_player:AnimationPlayer
@onready var sprite: FlippableSprite = $SpriteComponent/Sprite2D
@export_category("Player Movement")
@export var speed = 300.0
@export var jump_velocity = -400.0
var gravity:Vector2
@export var current_state: PlayerStates = PlayerStates.IDLE
@onready var flippable_component:FlippableComponent = $FlippableComponents
var in_ladder_collision:bool = false
var climb_speed:float = 200

enum PlayerStates{
    WALKING,
    RUNNING,
    JUMPING,
    FALLING,
    IDLE,
    ATTACKING,
    DODGING,
    CLIMBING
}
func _ready() -> void:
    gravity = get_gravity()

func _physics_process(delta: float) -> void:
    # Add the gravity.
    if not is_on_floor() and current_state != PlayerStates.CLIMBING:
        current_state=PlayerStates.FALLING
        velocity += get_gravity() * delta
    var up_down_direction := Input.get_axis("move_down","move_up")
    if in_ladder_collision and up_down_direction !=0 :
        velocity.y = up_down_direction * climb_speed
        current_state = PlayerStates.CLIMBING
        
    # Handle jump.
    if Input.is_action_just_pressed("jump") and is_on_floor() or in_ladder_collision:
        jump()

    # Get the input direction and handle the movement/deceleration.
    # As good practice, you should replace UI actions with custom gameplay actions.
    var direction := Input.get_axis("move_left", "move_right")
    if direction:
        velocity.x = direction * speed
        current_state=PlayerStates.RUNNING
        if direction>0:
            set_flip_character(false)
        elif direction<0:
            set_flip_character(true)

    else:
        velocity.x = move_toward(velocity.x, 0, speed)
    move_and_slide()
    if is_zero_approx(velocity.x) and is_on_floor():
        current_state=PlayerStates.IDLE
    
func jump()-> void:
    current_state = PlayerStates.JUMPING
    velocity.y = jump_velocity

func set_flip_character(value:bool)->void:
    sprite.flip_h=value
    flippable_component.flip(value)
    
func set_in_ladder_area(value:bool):
    in_ladder_collision=value
