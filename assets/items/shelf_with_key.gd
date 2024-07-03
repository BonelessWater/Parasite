extends Node2D

var close = false
var x = 0 
func _ready():
	pass # Replace with function body.



func _process(delta):
	if Input.is_action_just_pressed("interact") and close == true and x==0:
			Global.key_obtained = true
			Global.key_amount += 1
			$RichTextLabel.visible = true
			$Timer.start()
			x=1
			
	


func _on_area_2d_body_entered(body):
		close = true
		


func _on_area_2d_body_exited(body):
	close = false


func _on_timer_timeout():
	$RichTextLabel.visible = false
