extends Node2D
class_name HealthComponent

var max_health: float
var health: float

func _ready():
	max_health = get_parent().max_health
	health = max_health
	
func damage(attack_damage, knockback=0, knockback_dir=Vector2(0,0)):
	health -= attack_damage
	
	get_node('HealthBar').scale.x -= attack_damage/max_health
		
	if health <= 0:
		get_parent().queue_free()
		
	get_parent().velocity += knockback * knockback_dir
	print('knockback')
