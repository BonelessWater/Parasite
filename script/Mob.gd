extends CharacterBody2D

var health
var max_health
var speed
var attack_damage
var attack_speed

var taking_damage := false
var follow
var wanted_velocity
var velocity_delta
	

func _ready():
	health = Global.mob1_max_health
	max_health = Global.mob1_max_health
	
	speed = Global.mob1_speed
	attack_damage = Global.mob1_attack_damage
	attack_speed = Global.mob1_attack_damage
	
func _physics_process(delta):
	if follow:
		wanted_velocity = (get_parent().get_node('Player').position - position).normalized() * Global.mob1_speed * delta
		velocity_delta = velocity - wanted_velocity

		velocity -= velocity_delta * 0.1 # make this number larger to make the mob always follow the straighest path to the player 
		
		if velocity.x < 0:
			$AnimatedSprite2D.flip_h = true
		else: 
			$AnimatedSprite2D.flip_h = false

		move_and_slide()

func _on_view_range_body_entered(body):
	# Only the player has a method called player
	if body.has_method('player'):
		follow = true

func _on_view_range_body_exited(body):
	# Only the player has a method called player
	if body.has_method('player'):
		follow = false

# Identifier function, do not delete
func mob():
	pass
