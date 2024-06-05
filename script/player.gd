extends CharacterBody2D

var begin_process := false
var ani
var taking_damage := false

@export var SPEED := 30.0
@export var MAX_HEALTH := 100.0
@export var STAMINA := 5 # Seconds
@export var RUN_MULTIPLIER := 1.5

var keyObtained = false
var run_multiplier := 1.0
var health := MAX_HEALTH
var curr_direction := 'forward'
var distance_to_next_level := 0

# Weapon inventory
const weaponShowPath = preload('res://scene/WeaponDrops/WeaponShow.tscn')
var weaponShow
var weaponSprite
var weaponInHand := false
var weapons := {'Pistol': false, 'Shotgun': false, 'Rifle': false}
var Pistol
var Shotgut
var Rifle

# Ability inventory
var abilities = {'Dash': false}
var Dash

var aim
var game_node


func _ready():
	ani = $AnimatedSprite2D
	weaponShow = weaponShowPath.instantiate()
	Dash = get_parent().get_parent().get_node('Abilities/Dash')
	Pistol = get_parent().get_parent().get_node('Objects/Pistol')

func damage(attack_damage, _knockback):
	health -= attack_damage
	if health <= 0:
		queue_free()
	
	taking_damage = true

func rotateWeapon(node):
	aim = (get_global_mouse_position() - node.position).normalized()
	
	#if aim.x > 0:
	node.rotation = atan2(aim.y, aim.x)
	#else:
	#	node.rotation = atan2(aim.y, aim.x) + PI

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
	if Input.is_action_pressed('space'):
		# Check if user collected dash
		if abilities['Dash'] == true:
			get_parent().get_parent().get_node('Abilities/Dash').use(delta)
	
	if Input.is_action_pressed('attack'):
		# Check is user collected pistol
		if weapons['Pistol'] == true:
			Pistol.use(delta)
		# Add more weapons
		rotateWeapon(get_node('WeaponShow'))
	
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
