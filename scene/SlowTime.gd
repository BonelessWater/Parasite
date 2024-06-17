extends Node2D

@onready var cooldown = $Cooldown
@onready var duration = $Duration

# Called when the node enters the scene tree for the first time.
func _ready():
	cooldown.set_wait_time(Global.bulldozer_cooldown)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.THEWORLD and Input.is_action_just_pressed("e"):
		Global.movement_speed /= Global.player_speed_multiplier
		Global.mob1_speed /= Global.player_speed_mobs
		$Duration.start()

func _on_cooldown_timeout():
	Global.THEWORLD = true
	print("use ability")
	
	
		


func _on_duration_timeout():
	Global.THEWORLD = false
	$Cooldown.start()
	Global.movement_speed = 30000.0
	Global.mob1_speed = 10000
