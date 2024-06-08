extends Node2D
class_name HealthComponent

var MAX_HEALTH: float
var health: float

func _ready():
	MAX_HEALTH = get_parent().MAX_HEALTH
	health = MAX_HEALTH
	
func damage(attack_damage, knockback=0, knockback_dir=Vector2(0,0)):
	health -= attack_damage
	
	get_node('HealthBar').scale.x -= attack_damage/MAX_HEALTH
		
	if health <= 0:
		get_parent().queue_free()
		
	get_parent().velocity += knockback * knockback_dir
	print('knockback')
