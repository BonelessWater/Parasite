extends Control

var levels_scene = preload('res://scene/Levels/levels.tscn').instantiate()

func _on_start_pressed():
	get_tree().root.add_child(levels_scene)
	queue_free()
