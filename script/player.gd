extends CharacterBody2D

var begin_process = false
var ani

const SPEED = 30000.0
var curr_direction = 'forward'
var start_health = float(100)
var health = start_health
var distance_to_next_level = 0

# Weapon in inventory
var weapons = {'rifle': true, 'shotgun': false, 'pistol': false}
var curr_weapon = null
const bulletPath = preload('res://scene/bullet.tscn')
var shoot_cooldown = 0.1
var rifle

# Abilities
var abilities = {'dash': true}
var dash

func _ready():
	ani = $AnimatedSprite2D
	dash = get_parent().get_parent().get_node('Abilities/Dash')
	rifle = get_parent().get_parent().get_node('Objects/Weapon')

func input(delta):
	# Run if user has dash in inventory
	if Input.is_action_pressed('space'):
		# Check if user collected dash
		if abilities['dash'] == true:
			dash.use(delta)
	
	if Input.is_action_pressed('attack'):
		# Check is user collected rifle
		if weapons['rifle'] == true:
			rifle.use(delta)
	
	
	#if take_damage != 0 and health > 0:
	#	health -= take_damage
	#	get_node('Healthbar').scale.x -= take_damage/start_health
	#	take_damage = 0
	
	
	#if health <= 0:
	#	get_node('Healthbar').scale.x = 0
	#	ani.play('death')
	
	#distance_to_next_level = get_parent().get_node('GameLogic').distance_to_next_level
	#get_node('Expbar').set_value(distance_to_next_level)
	
	#$Weapon.look_at(get_global_mouse_position())
	
func movement(delta):
	var directionx = Input.get_axis("move_left", "move_right")
	var directiony = Input.get_axis("move_up", "move_down")
	if directionx or directiony:
		velocity.x = directionx * SPEED * delta
		velocity.y = directiony * SPEED * delta
		
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
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)
		velocity.y = move_toward(velocity.y, 0, SPEED * delta)
		
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
	
	
