extends CharacterBody2D

@export var hurtbox: HurtBoxComponent
@export var senses: SensesComponent
@export var health: HealthComponent
@export var action: ActionComponent
@export var pathfinding: PathfindingComponent
@export var animation_tree: AnimationTree
@export var resistances: Dictionary[DamageTypes.DamageType,float]
@export var player: Node2D

var anim_state_machine: AnimationNodeStateMachinePlayback

enum BehaviourState {
	UNAWARE,
	SUSPICIOUS,
	ALERT,
	ENGAGED
}

func _ready() -> void:
	anim_state_machine = animation_tree.get("parameters/playback") as AnimationNodeStateMachinePlayback
	anim_state_machine.start("wake")
	anim_state_machine.travel("idle")
	pathfinding.set_target(player)


func is_player_visible() -> bool:
	var target = senses.get_visible_hostile()
	return target != null

func on_health_depleted() -> void:
	pass

func move_to_target(_target: Node2D) -> void:
	pass

func light_attack() -> void:
	action.primary_action()
