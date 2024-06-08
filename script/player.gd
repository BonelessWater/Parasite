extends CharacterBody2D

var begin_process := false
var ani
var taking_damage := false

@export var movement_speed := 15000.0
@export var DASH_SPEED := 4.0
@export var DASH_LENGTH := 0.1
@export var MAX_HEALTH := 100.0
@export var STAMINA := 5 # Seconds
@export var RUN_MULTIPLIER := 1.5
var cooldown := 1
var cooldown_timer
var dash_length
var dash_timer
var is_dashing := false

var keyObtained := false
var run_multiplier := 1.0
var health := MAX_HEALTH
var curr_direction := 'forward'
var distance_to_next_level := 0

# Weapon inventory
const weaponShowPath := preload('res://scene/WeaponDrops/WeaponShow.tscn')
var weaponShow
var weaponSprite
var weaponInHand := false
var weapons := {'Pistol': false, 'Shotgun': false, 'Rifle': false}
var Pistol
var Shotgut
var Rifle

# Ability inventory
var abilities := {'Dash': false}
var Dash
var dashlength

var aim
var game_node


func _ready():
	ani = $AnimatedSprite2D
	weaponShow = weaponShowPath.instantiate()
	Dash = get_parent().get_parent().get_node('Abilities/Dash')
	Pistol = get_parent().get_parent().get_node('Objects/Pistol')
	
	cooldown_timer = get_node('cooldown')
	cooldown_timer.set_wait_time(cooldown)
	
	dash_length = get_node('dash_length')
	dash_length.set_wait_time(DASH_LENGTH)

func damage(attack_damage, _knockback):
	health -= attack_damage
	if health <= 0:
		queue_free()
	
	taking_damage = true

func input(delta):
	# Check what weapon is in player's hand
	for weapon in weapons:
		if weapons[weapon] == true:
			if weapon == 'Pistol' and weaponInHand == false:
				add_child(weaponShow)
				weaponSprite = get_node('WeaponShow/Sprite2D')
				# This code takes a specific pistol from a large image of weapons
				weaponSprite.texture = ResourceLoader.load('res://assets/weapons/1.png')
				weaponSprite.region_enabled = true
				weaponSprite.region_rect = Rect2(0, 118, 12, 10)
				weaponInHand = true
				
	# Run if user has dash in inventory
	
	
	if Input.is_action_pressed('attack'):
		# Check is user collected pistol
		if weapons['Pistol'] == true:
			Pistol.use(delta)
		# Add more weapons
	
	#distance_to_next_level = get_parent().get_node('GameLogic').distance_to_next_level
	#get_node('Expbar').set_value(distance_to_next_level)

func movement(delta):
	if Input.is_action_pressed('space'):
		# Check if user collected dash
		if abilities['Dash'] == true and cooldown_timer.time_left == 0:
			is_dashing = true
			cooldown_timer.start()
			
	if is_dashing == true: 
		dash_length.start()
		is_dashing = false
		
	if dash_length.time_left >= 0.05:
		DASH_SPEED = 10
	else:
		DASH_SPEED = 1

		
	var directionx = Input.get_axis("move_left", "move_right")
	var directiony = Input.get_axis("move_up", "move_down")
	if Input.is_action_pressed('shift') and STAMINA > 0:
		run_multiplier = RUN_MULTIPLIER
	elif STAMINA < 5:
		STAMINA += delta # smart use of delta :)
	else:
		run_multiplier = 1
		
	# Direction player wants to go
	var wanted_velocity = Vector2(directionx, directiony)  * movement_speed * delta * run_multiplier * DASH_SPEED
	var velocity_delta = velocity - wanted_velocity
	
	velocity -= velocity_delta * 0.1 # increase the coefficient to make the movement feel more instant

	if abs(velocity.x) <= 0.1:
		velocity.x = 0 
	if abs(velocity.y) <= 0.1:
		velocity.y = 0 
			
	if velocity:
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
		velocity.x = move_toward(velocity.x, 0, movement_speed * delta * run_multiplier * DASH_SPEED)
		velocity.y = move_toward(velocity.y, 0, movement_speed * delta * run_multiplier * DASH_SPEED)
		
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
