extends Node2D
@onready var Duration = $Duration
@onready var cooldown = $Cooldown

# Called when the node enters the scene tree for the first time.
func _ready():
	Duration.set_wait_time(Global.bulldozer_wait)
	Duration.set_one_shot(true)
	
	cooldown.set_wait_time(Global.bulldozer_cooldown)
	cooldown.set_one_shot(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Global.is_bulldozer == true and cooldown.time_left <= 0.05: 
		Duration.start()
		cooldown.start()
		Global.is_bulldozer = false
		
		
	if Duration.time_left <= 0.10:
		Global.max_health == Global.old_health
	

func _on_duration_timeout():
	Global.max_health = Global.old_health
	
	Global.is_bulldozer = false
