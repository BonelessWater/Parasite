extends CharacterBody2D

var MAX_HEALTH := 20.0
var health
var taking_damage := false

func damage(attack_damage):
	health -= attack_damage
	
	if health <= 0:
		queue_free()
	
	taking_damage = true
	
func _ready():
	health = MAX_HEALTH
	
func _physics_process(_delta):
	pass
