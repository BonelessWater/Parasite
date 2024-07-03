extends Node2D
var notes = preload("res://scene/Notes/note1.tscn").instantiate()
var note = false
var x =0
# Called when the node enters the scene tree for the first time.
func _ready():
	$RichTextLabel.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed('interact') and note == true and x==0:
		Global.note1 = true
		$RichTextLabel.visible = true
		$Timer.start()
		x+=1
		queue_free()


func _on_area_2d_body_entered(body):
	note = true
		


func _on_area_2d_body_exited(body):
	note = false


func _on_timer_timeout():
	$RichTextLabel.visible = false
