extends Node2D

@onready var timer = get_node('Cooldown')
@onready var dash_duration = get_node('DashDuration')

func _ready():
	# Setting up timer
	timer.set_wait_time(Global.dash_cooldown)
	timer.set_one_shot(true)
	# Setting up timer
	dash_duration.set_wait_time(Global.dash_length)
	dash_duration.set_one_shot(true)

func _process(_delta):
	if Global.is_dashing == true: 
		dash_duration.start()
		Global.is_dashing = false
		
	if dash_duration.time_left >= 0.05:
		Global.dash_speed = Global.max_dash_speed
	else:
		Global.dash_speed = 1
