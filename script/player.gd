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
var weaponInHand := false

var weapons := {'Pistol': false, 'Shotgun': false, 'Rifle': false}
var Pistol
var Shotgun
var Rifle

# Ability inventory
var abilities := {'Dash': false, 'AOE': false, 'Bubble': false, 'Ram': false, 'Bulldozer': false}
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
	max_health = Global.max_health
	max_sprint = Global.max_sprint
	stamina = Global.stamina
	
	ani = $AnimatedSprite2D
	
	Dash = game_node.get_node('Abilities/Dash')
	Bubble = game_node.get_node('Abilities/Bubble')
	BubbleSprite = $BubbleSprite
	Pistol = game_node.get_node('Objects/Pistol')
	Shotgun = game_node.get_node('Objects/Shotgun')

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
	
		

func input(delta):
	if Input.is_action_pressed('attack'):
		# Check if user collected pistol
		if weapons['Pistol'] == true:
			Global.weapon_name = 'Pistol'
			Pistol.use(delta)
		if weapons['Shotgun'] == true:
			Global.weapon_name = 'Shotgun'
			Shotgun.use(delta)
		# Add more weapons
		
	if Global.is_bulldozer and Input.is_action_just_pressed("e"):
		Global.old_health = Global.max_health
		Global.old_speed = Global.movement_speed
		print(Global.old_health)
		print(Global.old_speed)
		get_node('HealthComponent').damage(-Global.bulldozer_health)
		Global.movement_speed += Global.bulldozer_speed
		
	if Input.is_action_pressed('e'):
		# Check if user has bubble...  this logic will change later 
		if Global.abilities['Bubble'] == true:
			Global.bubble_on = true
		if Global.abilities['Ram'] == true:
			Global.is_ramming = true
		if Global.abilities['Bulldozer'] == true:
			Global.is_bulldozer = true
		if Global.abilities['SlowTime'] == true:
			Global.slow_time = true
			
	if Input.is_action_just_pressed("skill_tree"):
		get_tree().change_scene_to_file("res://scene/skill_tree.tscn")
		
func movement(delta):
	if Input.is_action_just_pressed('space'):
		# Check if user collected dash
		if abilities['Dash'] == true:
			Global.is_dashing = true
	
	var directionx = Input.get_axis("move_left", "move_right")
	var directiony = Input.get_axis("move_up", "move_down")
	
	look_dir(directionx, directiony)

	if Input.is_action_pressed('shift') and stamina > 0:
		sprint = max_sprint
	elif stamina < 5:
		stamina += delta # smart use of delta :)
	else:
		sprint = 1

	# Direction player wants to go
	var wanted_velocity = Vector2(directionx, directiony) * Global.movement_speed * delta * sprint * Global.dash_speed
	if wanted_velocity:
		Global.last_vel = wanted_velocity
	var velocity_delta = velocity - wanted_velocity
	
	if Global.is_ramming:
		velocity = Global.ram_vel
	else:
		velocity -= velocity_delta * 0.1 # increase the coefficient to make the movement feel more instant
		
	if abs(velocity.x) <= 0.1:
		velocity.x = 0 
	if abs(velocity.y) <= 0.1:
		velocity.y = 0 
	move_and_slide()

func look_dir(directionx, directiony):
	if directionx > 0:
		curr_direction = 'right'
	elif directionx < 0:
		curr_direction = 'left'
	elif directionx < 0:
		curr_direction = 'up'
	else:
		curr_direction = 'down'
	
	if directionx != 0:
		ani.play('side_walk')
		if directionx > 0:
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true
	elif directiony < 0:
		ani.play('back_walk')
	elif directiony > 0:
		ani.play('forward_walk')
	else:
		if curr_direction == 'left':
			$AnimatedSprite2D.flip_h = false
			ani.play('side')
		elif curr_direction == 'right':
			$AnimatedSprite2D.flip_h = true
			ani.play('side')
		elif curr_direction == 'back':
			ani.play('back')
		else:
			ani.play('forward')

# Identifier function
func player():
	pass

func _on_area_2d_body_entered(body):
	if body.has_method('wall'):
		Global.wall_col = true
	elif body.has_method('door'):
		Global.wall_col = true

func _on_area_2d_body_exited(body):
	if body.has_method('wall'):
		Global.wall_col = false
	elif body.has_method('door'):
		Global.wall_col = false
