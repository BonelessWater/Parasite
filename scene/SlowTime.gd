extends Node2D

@onready var cooldown = $Cooldown
@onready var duration = $Duration

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.slow_time == true:
		cooldown.set_wait_time(Global.slow_time_cooldown)
		cooldown.one_shot = true
		duration.set_wait_time(Global.slow_time_duration)
		$Cooldown.start()
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if  Global.abilities['SlowTime'] == true and Input.is_action_just_pressed("e"):
		$Duration.start()
	
func _on_cooldown_timeout():
	Global.abilities['SlowTime'] = true
	

func _on_duration_timeout():
	Global.abilities['SlowTime'] = false
	
	$Cooldown.one_shot = false
	$Cooldown.start()
	Global.movement_speed = 30000.0
	Global.mob1_speed = 10000
