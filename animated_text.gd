extends Node2D

var x = 0
func _ready():
	$Label.visible = false
	
	 
func _on_area_2d_body_entered(body):
	if x==0:
		$AnimationPlayer.play("text")
		$Label.visible = true
		x+=1
		$Timer.start()


func _on_timer_timeout():
	$Label.visible = false
