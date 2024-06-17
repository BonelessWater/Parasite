extends Node2D
@onready var duration_timer = get_node('Duration')

# Called when the node enters the scene tree for the first time.
func _ready():
	duration_timer.set_wait_time(Global.bulldozer_wait)
	duration_timer.set_one_shot(true)
	duration_timer.connect("timeout", Callable(self, "_on_timer_timeout"))



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Global.is_bulldozer and Input.is_action_just_pressed("e"):
		Global.old_health = Global.max_health
		Global.old_speed = Global.movement_speed
		Global.max_health += Global.bulldozer_health
		Global.movement_speed += Global.bulldozer_speed
		duration_timer.start()
		print("Bulldozer activated. Timer started.")

func _on_timer_timeout():
	Global.max_health = Global.old_health
	Global.movement_speed = Global.old_speed
	Global.is_bulldozer = false
	print("Bulldozer duration ended. Health and speed reset.")
