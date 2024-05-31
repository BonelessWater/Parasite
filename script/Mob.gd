extends CharacterBody2D

@export var MAX_HEALTH := 20.0
@export var speed := 1000
@export var attack_damage := 10.0
@export var attack_speed := 1.0
var health
var taking_damage := false
var follow
var dir_to_player
	
func _ready():
	health = MAX_HEALTH
	
func _physics_process(delta):
	if follow:
		dir_to_player = (get_parent().get_node('Player').position - position).normalized()
		velocity = dir_to_player * speed * delta
		
		if velocity.x < 0:
			$AnimatedSprite2D.flip_h = true
		else: 
			$AnimatedSprite2D.flip_h = false

		move_and_slide()

func _on_view_range_body_entered(body):
	print('enter')
	# Only the player has a method called player
	if body.has_method('player'):
		follow = true

func _on_view_range_body_exited(body):
	print('exit')
	# Only the player has a method called player
	if body.has_method('player'):
		follow = false

# Identifier function, do not delete
func mob():
	pass
