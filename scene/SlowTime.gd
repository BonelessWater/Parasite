extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.slow_time and Input.is_action_just_pressed("e"):
		Global.movement_speed /= Global.player_speed_multiplier
		Global.mob1_speed /= Global.player_speed_mobs
		print(Global.movement_speed)
