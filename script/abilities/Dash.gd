extends Node2D

@onready var timer = get_node('Cooldown')
@onready var dash_duration = get_node('DashDuration')

# get balancing varaibles from the game node
var game_node
var is_dashing
var dash_length
var dash_speed
var dash_cooldown

func _ready():
	game_node = get_parent().get_parent()
	
	dash_speed = game_node.dash_speed
	
	# Setting up timer
	dash_cooldown = game_node.dash_cooldown
	timer.set_wait_time(dash_cooldown)
	timer.set_one_shot(true)
	# Setting up timer
	dash_length = game_node.dash_length
	dash_duration.set_wait_time(dash_length)
	dash_duration.set_one_shot(true)

func _process(_delta):
	is_dashing = game_node.is_dashing
	#print(dash_duration.time_left)
	if is_dashing == true: 
		dash_duration.start()
		game_node.is_dashing = false
		
	if dash_duration.time_left >= 0.05:
		game_node.dash_speed = game_node.max_dash_speed
	else:
		game_node.dash_speed = 1
	print(game_node.dash_speed)
