extends Node2D

@onready var Duration = $Duration
@onready var cooldown = $Cooldown

# Called when the node enters the scene tree for the first time.
func _ready():
	Duration.wait_time = Global.bulldozer_wait
	Duration.one_shot = true
	
	cooldown.wait_time = Global.bulldozer_cooldown
	cooldown.one_shot = true
	
	# Connect signals for timers
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Global.is_bulldozer and cooldown.time_left <= 0.05: 
		# Save the original health and speed before applying bulldozer effect
		Global.old_health = Global.max_health
		Global.old_speed = Global.movement_speed
		
		# Apply bulldozer effect
		Global.max_health += Global.bulldozer_health
		Global.movement_speed += Global.bulldozer_speed
		
		# Start the duration and cooldown timers
		Duration.start()
		cooldown.start()
		Global.is_bulldozer = false
		
	# Revert health and speed when duration ends
	if Duration.time_left <= 0.10:
		Global.max_health = Global.old_health


func _on_duration_timeout():
	Global.max_health = Global.old_health
	
	Global.is_bulldozer = false

func _on_cooldown_timeout():
	# This function can be used to handle any logic after the cooldown ends if needed
	pass
