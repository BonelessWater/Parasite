extends Control
var nice

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.level_status == 'tutorial':
		nice = preload("res://scene/game.tscn").instantiate()


func _on_back_pressed():
	get_tree().root.add_child(nice)
	queue_free()
