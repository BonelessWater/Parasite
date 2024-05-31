extends Node2D
class_name HealthComponent

var MAX_HEALTH: float
var health: float

func _ready():
	MAX_HEALTH = get_parent().MAX_HEALTH
	health = MAX_HEALTH
	
func damage(attack_damage, _knockback):
	print('damaged')
	health -= attack_damage
	
	get_node('HealthBar').scale.x -= attack_damage/MAX_HEALTH
		
	if health <= 0:
		get_parent().queue_free()
