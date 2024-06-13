extends Node2D
class_name HealthComponent

var max_health
var health
var health_assigned := false

func _ready():
	health = max_health
	
func damage(attack_damage, knockback=0, knockback_dir=Vector2(0,0)):
	max_health = get_parent().max_health
	if !health_assigned:
		health = max_health
		health_assigned = true
		
	if Global.invul == false:
		health -= attack_damage
		get_node('HealthBar').scale.x -= attack_damage/max_health
		get_parent().velocity += knockback * knockback_dir
		
	if health <= 0:
		get_parent().queue_free()
		
	
	
