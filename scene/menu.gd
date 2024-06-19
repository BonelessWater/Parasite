extends Control


var levels_scene = preload("res://scene/levels.tscn").instantiate()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_start_pressed():
	get_tree().root.add_child(levels_scene)
	queue_free()
