extends Node2D


@export var dash_distance := 10000.0
@export var dash_cooldown := 1
@export var dash_speed := 10.0

var dash_on := false
var timer
var player
var cursor_direction

func _ready():
	timer = get_node('Timer')
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
	print(timer.time_left)
	if timer.time_left <= 0.05:
		cursor_direction = (get_viewport().get_mouse_position() - player.position).normalized()
		player.position += cursor_direction * dash_distance * delta
		timer.start()

