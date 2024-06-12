extends Node2D

@onready var timer = get_node('Cooldown')
@onready var dash_duration = get_node('DashDuration')

var is_dashing
var dash_length
var dash_speed
var dash_cooldown

func _ready():
	dash_speed = Global.dash_speed
	
	# Setting up timer
	dash_cooldown = Global.dash_cooldown
	timer.set_wait_time(dash_cooldown)
	timer.set_one_shot(true)
	# Setting up timer
	dash_length = Global.dash_length
	dash_duration.set_wait_time(dash_length)
	dash_duration.set_one_shot(true)

func _process(_delta):
	is_dashing = Global.is_dashing
	if is_dashing == true: 
		dash_duration.start()
		Global.is_dashing = false
		
	if dash_duration.time_left >= 0.05:
		Global.dash_speed = Global.max_dash_speed
	else:
		Global.dash_speed = 1
