extends Node2D
@onready var Duration = $Duration
@onready var cooldown = $Cooldown

# Called when the node enters the scene tree for the first time.
func _ready():
		if Global.is_bulldozer:
			Duration.set_wait_time(Global.bulldozer_wait)
			cooldown.set_wait_time(Global.bulldozer_cooldown)
			$Cooldown.one_shot = false
			$Cooldown.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Global.abilities['Bulldozer'] == true and Input.is_action_just_pressed("e"):
		Duration.start()
		
func _on_duration_timeout():
	cooldown.set_one_shot(true)
	cooldown.start()
	Global.max_health = Global.old_health
	Global.movement_speed = Global.old_speed
	print("ability off")


func _on_cooldown_timeout():
	Global.abilities['Bulldozer']
	print("use ability")
