extends Node2D
class_name HealthComponent


var health
var health_assigned := false

func _ready():
	health = Global.max_health
	
	
func damage(attack_damage, knockback=0, knockback_dir=Vector2(0,0)):
	
	if !health_assigned:
		health_assigned = true
		
	if Global.invul == false:
		health -= attack_damage
		get_node('HealthBar').scale.x -= attack_damage/health
		get_parent().velocity += knockback * knockback_dir
		
	if health <= 0:
		get_parent().queue_free()
		
	
func _process(delta):
	Global.old_health = health
	
