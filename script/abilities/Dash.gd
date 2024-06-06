extends Node2D

@export var dash_cooldown := 1
@export var dash_speed := 1000000.0
@export var dash_duration := 0.3

var dash_used := false
var dash_on
var cooldown
var player
var cursor_direction
var speed
var time_passed = 0
var player_vel

func _ready():
	cooldown = get_node('Cooldown')
	cooldown.set_wait_time(dash_cooldown)
	dash_on = get_node('On')
	dash_on.set_wait_time(dash_duration)
	
# Dash is more like a very quick and large speed boost, We can add invincibility frames from as well.
func use(_delta):
	# Find the location of the player node according to the game information
	var game_node = get_parent().get_parent()
	if game_node.level_status == 'Tutorial':
		player = game_node.get_node('Tutorial/Player')
	elif game_node.level_status == 'Level1':
		player = game_node.get_node('Level1/Player')
	elif game_node.level_status == 'Level2':
		player = game_node.get_node('Level2/Player')
	elif game_node.level_status == 'Level3':
		player = game_node.get_node('Level3/Player')
	if cooldown.time_left <= 0.05:
		player_vel = player.velocity
		dash_used = true
		cooldown.start()
		dash_on.start()
	
func _process(delta):
	if dash_used == true:
		time_passed += delta
		cursor_direction = (get_viewport().get_mouse_position() - player.position).normalized()
		print(get_viewport().get_mouse_position() - player.position)
		player.velocity = player_vel + cursor_direction * speed_function() * delta

		if dash_on.time_left <= 0.05:
			dash_used = false
			time_passed = 0
		
# We can change this function to make the dash look more natural
func speed_function():
	if time_passed < dash_duration:
		speed = (dash_duration - time_passed) * dash_speed
	else:
		speed = 0
	return speed
