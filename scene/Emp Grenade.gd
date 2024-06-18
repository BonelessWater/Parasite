extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$cooldown.set_wait_time(Global.emp_cooldown)
	$cooldown.one_shot = true
	$duration.set_wait_time(Global.emp_duration)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.emp_throw and Input.is_action_just_pressed("e"):
		$duration.start()


func _on_cooldown_timeout():
	Global.emp_throw = true
	print("use abilitiy")


func _on_duration_timeout():
	Global.emp_throw = false
	$cooldown.one_shot = false
	$cooldown.start()
	Global.mob1_speed = 10000
