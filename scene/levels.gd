extends Control

var simultaneous_scene = preload("res://scene/game.tscn").instantiate()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_tutorial_pressed():
	get_tree().root.add_child(simultaneous_scene)
	queue_free()
