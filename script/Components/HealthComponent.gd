extends Node2D
class_name HealthComponent

var health
var health_assigned := false

func _ready():
	if get_parent().has_method('player'): # the health component is a node that every entity uses so define health according to its parents.
		health = Global.max_health
	elif get_parent().has_method('mob'):
		health = Global.mob1_max_health
	
func damage(attack_damage, knockback=0, knockback_dir=Vector2(0,0)):
	
	if !health_assigned:
		health_assigned = true
	
	if get_parent().has_method('player'):
		if Global.invul == false:
			Global.max_health -= attack_damage
			get_node('HealthBar').scale.x -= attack_damage/Global.max_health
			get_parent().velocity += knockback * knockback_dir
			print(Global.max_health)
			
		if Global.max_health <= 0 and Global.totem == true:
			Global.max_health = Global.totem_health
			Global.consumable_amount_totem -=1
			print(Global.consumable_amount_totem)
		elif Global.max_health <= 0: # this is only for the player
			get_parent().ani.play('death')
	else: # only for enemies
		health -= attack_damage
		get_node('HealthBar').scale.x -= attack_damage/Global.max_health
		get_parent().velocity += knockback * knockback_dir
		
		if health <= 0:
			get_parent().queue_free()
		
func _process(_delta):
	Global.old_health = health
