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
var player_radius
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
var abilities := {'Dash': false, 'AOE': false, 'Bubble': false}
var Dash
var AOE
var Bubble
var BubbleSprite
var aim

var game_node
var hitbox

func _ready():
	hitbox = get_node('Hitbox')
	game_node = get_parent().get_parent()
	
	health = Global.max_health
	movement_speed = Global.movement_speed
	max_health = Global.max_health
	max_sprint = Global.max_sprint
	stamina = Global.stamina
	
	ani = $AnimatedSprite2D
	
	weaponShow = weaponShowPath.instantiate()
	Dash = game_node.get_node('Abilities/Dash')
	Bubble = game_node.get_node('Abilities/Bubble')
	BubbleSprite = $BubbleSprite
	Pistol = game_node.get_node('Objects/Pistol')

func _process(_delta): # use this function to refresh values
	hitbox.get_shape().set_radius(Global.player_hitbox_r)
	hitbox.get_shape().set_height(Global.player_hitbox_h)
	
	if hitbox.get_shape().get_radius() == Global.player_radius: # most ratchet ass code i've made. but it works - dom
		BubbleSprite.play('off')
	else:
		BubbleSprite.play('on')
		
	if Global.give_bubble_health:
		get_node('HealthComponent').damage(-Global.bubble_health)
		Global.give_bubble_health = false
		
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
				
	if Input.is_action_pressed('attack'):
		# Check if user collected pistol
		if weapons['Pistol'] == true:
			Pistol.use(delta)
		# Add more weapons
	
	if Input.is_action_pressed('e'):
		# Check if user has bubble...  this logic will change later 
		if abilities['Bubble'] == true:
			Global.bubble_on = true
			
func movement(delta):
	if Input.is_action_just_pressed('space'):
		# Check if user collected dash
		if abilities['Dash'] == true:
			Global.is_dashing = true
	dash_speed = Global.dash_speed
	
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
	# Check for direction inputs and set the current direction
		if Input.is_action_just_pressed("move_right"):
			curr_direction = 'right'
			$AnimatedSprite2D.flip_h = false
		elif Input.is_action_just_pressed("move_left"):
			curr_direction = 'left'
			$AnimatedSprite2D.flip_h = true
		elif Input.is_action_just_pressed("move_up"):
			curr_direction = 'back'
		elif Input.is_action_just_pressed("move_down"):
			curr_direction = 'forward'

	# Play the appropriate walking animation based on the current direction
		match curr_direction:
			'right', 'left':
				ani.play('side_walk')
			'back':
				ani.play('back_walk')
			'forward':
				ani.play('forward_walk')
	else:
		velocity.x = move_toward(velocity.x, 0, movement_speed * delta * sprint * dash_speed)
		velocity.y = move_toward(velocity.y, 0, movement_speed * delta * sprint * dash_speed)
	
	# Play the appropriate idle animation based on the current direction
		match curr_direction:
			'right', 'left':
				ani.play('side')
			'back':
				ani.play('back')
			'forward':
				ani.play('forward')

	move_and_slide()


# Identifier function, do not remove
func player():
	pass
