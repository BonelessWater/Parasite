extends Node2D

@onready var cooldown = get_node('Cooldown')
@onready var duration = get_node('Duration')

func _ready():

	# Setting up timer
	cooldown.set_wait_time(Global.ram_cooldown)
	cooldown.set_one_shot(true)
	
	duration.set_wait_time(Global.ram_duration)
	duration.set_one_shot(true)

func _process(_delta):
	if Global.is_ramming and cooldown.get_time_left() <= 0.05: 
		cooldown.start()
		duration.start()
		Global.ram_vel = Global.last_vel * Global.ram_speed
		Global.invul = true
		
	if Global.wall_col or Global.door_col or duration.get_time_left() <= 0.05 :
		Global.is_ramming = false
		Global.invul = false
