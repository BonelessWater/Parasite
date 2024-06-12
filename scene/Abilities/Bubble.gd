extends RigidBody2D

@onready var timer = get_node('Cooldown')

var max_health
var bubble_cooldown
var bubble_on

func _ready():
	max_health = Global.bubble_health
	
	# Setting up timer
	bubble_cooldown = Global.bubble_cooldown
	timer.set_wait_time(bubble_cooldown)
	timer.set_one_shot(true)

func _process(_delta):
	bubble_on = Global.bubble_on
	if bubble_on == true: 
		timer.start()
	
	#if get_node('HealthComponent').health <= 0:
	#	Global.bubble_on = false
	#el
	if bubble_on:
		if timer.time_left >= 0.05:
			Global.bubble_on = false
			queue_free()
		
