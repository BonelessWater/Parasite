extends CharacterBody2D

@export var MAX_HEALTH := 20.0
@export var speed := 1000
@export var attack_damage := 10.0
@export var attack_speed := 1.0
var health
var taking_damage := false
var follow
var wanted_velocity
var velocity_delta
	
func _ready():
	health = MAX_HEALTH
	
func _physics_process(delta):
	if follow:
		wanted_velocity = (get_parent().get_node('Player').position - position).normalized() * speed * delta
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
