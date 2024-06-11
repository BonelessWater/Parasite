extends Control

var simultaneous_scene = preload("res://scene/game.tscn").instantiate()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_pressed():
	get_tree().root.add_child(simultaneous_scene)
	queue_free()
