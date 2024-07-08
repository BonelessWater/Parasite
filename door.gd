extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("closed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if Input.is_action_just_pressed("interact"):
		$AnimatedSprite2D.play("opening")
		
		$Timer.start()


func _on_timer_timeout():
	$AnimatedSprite2D.play("opened")
