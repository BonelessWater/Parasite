extends CharacterBody2D

var begin_process = false
var ani
var taking_damage := false

@export var SPEED := 30.0
@export var MAX_HEALTH := 100.0
@export var STAMINA := 5 # Seconds
@export var RUN_MULTIPLIER := 1.25

var run_multiplier = 1
var health = MAX_HEALTH
var curr_direction := 'forward'
var distance_to_next_level = 0

# Weapon inventory
var weapons = {'rifle': true, 'shotgun': false, 'pistol': false}
var rifle
var shotgut
var pistol

# Ability inventory
var abilities = {'dash': true}
var dash

func _ready():
	ani = $AnimatedSprite2D
	dash = get_parent().get_parent().get_node('Abilities/Dash')
	rifle = get_parent().get_parent().get_node('Objects/Weapon')

func damage(attack_damage, _knockback):
	health -= attack_damage
	if health <= 0:
		queue_free()
	
	taking_damage = true

func input(delta):
	# Run if user has dash in inventory
	if Input.is_action_pressed('space'):
		# Check if user collected dash
		if abilities['dash'] == true:
			get_parent().get_parent().get_node('Abilities/Dash').use(delta)
	
	if Input.is_action_pressed('attack'):
		# Check is user collected rifle
		if weapons['rifle'] == true:
			rifle.use(delta)
	
	#distance_to_next_level = get_parent().get_node('GameLogic').distance_to_next_level
	#get_node('Expbar').set_value(distance_to_next_level)

func movement(delta):
	var directionx = Input.get_axis("move_left", "move_right")
	var directiony = Input.get_axis("move_up", "move_down")
	if Input.is_action_pressed('shift') and STAMINA > 0:
		run_multiplier = RUN_MULTIPLIER
	elif STAMINA < 5:
		STAMINA += delta # smart use of delta :)
	else:
		run_multiplier = 1
		
	if directionx or directiony:
		velocity.x = directionx * SPEED * delta * run_multiplier
		velocity.y = directiony * SPEED * delta * run_multiplier
		
		# Look direction 
		if velocity.x > 0:
			curr_direction = 'right'
			$AnimatedSprite2D.flip_h = false
			ani.play('side_walk')
		elif velocity.x < 0:
			curr_direction = 'left'
			$AnimatedSprite2D.flip_h = true
			ani.play('side_walk')
		elif velocity.y < 0:
			curr_direction = 'back'
			ani.play('back_walk')
		else:
			curr_direction = 'forward'
			ani.play('forward_walk')
			
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta * run_multiplier)
		velocity.y = move_toward(velocity.y, 0, SPEED * delta * run_multiplier)
		
		# Look direction 
		if velocity.x > 0:
			curr_direction = 'right'
			$AnimatedSprite2D.flip_h = false
			ani.play('side')
		elif velocity.x < 0:
			curr_direction = 'left'
			$AnimatedSprite2D.flip_h = true
			ani.play('side')
		elif velocity.y < 0:
			curr_direction = 'back'
			ani.play('back')
		else:
			curr_direction = 'forward'
			ani.play('forward')
			
	move_and_slide()

# Identifier function, do not remove
func player():
	pass
