extends Node2D
var notes = preload("res://scene/Notes/note1.tscn").instantiate()
var note = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed('interact') and note == true:
		queue_free()
		Global.note1 = true
	


func _on_area_2d_body_entered(body):
	note = true
		


func _on_area_2d_body_exited(body):
	note = false
