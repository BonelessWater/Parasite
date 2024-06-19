extends Node2D
@onready var Duration = $Duration
@onready var cooldown = $Cooldown

# Called when the node enters the scene tree for the first time.
func _ready():
		Duration.set_wait_time(Global.bulldozer_wait)
		cooldown.set_wait_time(Global.bulldozer_cooldown)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Global.reinhartd and Input.is_action_just_pressed("e"):
		Duration.start()
		
	if Global.is_bulldozer:
		cooldown.set_one_shot(true)
		cooldown.start()
		
func _on_duration_timeout():
	$Cooldown.one_shot = false
	$cooldown.start()
	Global.max_health = Global.old_health
	Global.movement_speed = Global.old_speed
	Global.reinhartd = false


func _on_cooldown_timeout():
	Global.reinhartd = true
	print("use ability")
