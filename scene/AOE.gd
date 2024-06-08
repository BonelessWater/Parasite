extends Node2D

@onready var timer = get_node('Cooldown')

func start_dash(dur):
	timer.set_wait_time(dur)
	timer.start()

func is_dashing():
	print(timer.time_left)
	if timer.time_left <= 0.05:
		return !timer.is_stopped()
	return timer.is_stopped()
