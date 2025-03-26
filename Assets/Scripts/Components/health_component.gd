extends Node

class_name HealthComponent

@export var max_health:float = 100
@export var current_health:float = 100
@export var scale_factor:float = 1
@export var resistance_factor = 1
@export var resistances:Dictionary[DamageTypes.DamageType, float]
@warning_ignore("unused_signal")
signal health_changed
signal health_depleted

func heal(amount:float):
	current_health = clampf(current_health+amount,0,max_health)
func take_damage(damage_entries:Array[DamageEntry]):
	var total_damage:float = 0
	for damage_entry in damage_entries:
		var amount = damage_entry.damage_amount
		var dtype = damage_entry.damage_type
		var resistance:float = resistances.get(dtype,0.0) * resistance_factor
		var modified_damage:float = max(amount - resistance,1.0)
		total_damage+=modified_damage
	current_health = clampf(current_health-total_damage,0,max_health)
	if(current_health<=0):
		emit_signal("health_depleted")
	emit_signal("health_changed", current_health)
