extends CharacterBody2D

var begin_process := false

var ani
var taking_damage := false

var keyObtained := false
var sprint := 1.0

var health
var max_health
var dash_speed
var movement_speed
var max_sprint
var stamina
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
var abilities := {'Dash': false, 'AOE': false}
var Dash
var AOE

var aim
var game_node


func _ready():
	game_node =  get_parent().get_parent()
	
	health = game_node.max_health
	movement_speed = game_node.movement_speed
	health = game_node.max_health
	max_health = game_node.max_health
	max_sprint = game_node.max_sprint
	stamina = game_node.stamina
	
	ani = $AnimatedSprite2D
	weaponShow = weaponShowPath.instantiate()
	Dash = get_parent().get_parent().get_node('Abilities/Dash')
	Pistol = get_parent().get_parent().get_node('Objects/Pistol')
	
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
	if Input.is_action_just_pressed('space'):
		# Check if user collected dash
		if abilities['Dash'] == true:
			game_node.is_dashing = true
	dash_speed = game_node.dash_speed
	
	var directionx = Input.get_axis("move_left", "move_right")
	var directiony = Input.get_axis("move_up", "move_down")
	if Input.is_action_pressed('shift') and stamina > 0:
		sprint = max_sprint
	elif stamina < 5:
		stamina += delta # smart use of delta :)
	else:
		sprint = 1
	if Input.is_action_just_pressed("skill_tree"):
		get_tree().change_scene_to_file("res://scene/skill_tree.tscn")
		
		
	# Direction player wants to go
	var wanted_velocity = Vector2(directionx, directiony)  * movement_speed * delta * sprint * dash_speed
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
		velocity.x = move_toward(velocity.x, 0, movement_speed * delta * sprint * dash_speed)
		velocity.y = move_toward(velocity.y, 0, movement_speed * delta * sprint * dash_speed)
		
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
