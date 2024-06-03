extends Node2D

const timerPath = preload("res://scene/timer.tscn")

var dash_distance := 10000.0
var dash_speed
var dash_on := false
var dash_cooldown := 1
var timer
var player

func _ready():
	timer = timerPath.instantiate()
	timer.set_wait_time(dash_cooldown)

func use(delta):
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
		
	if dash_on == true and timer.time_left() == 0:
		var cursor_direction = (get_viewport().get_mouse_position() - player.position).normalized()
		player.position += cursor_direction * dash_distance * delta
		timer.start()
	dash_on = false

