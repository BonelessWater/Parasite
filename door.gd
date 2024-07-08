extends Node2D

var closedoor = false
var x =1
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("closed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		

func _on_area_2d_body_entered(body):
	
	
	if body.has_method("player"):
		$AnimatedSprite2D.play("opening")
		$Timer.start()
		closedoor = true
		if closedoor and x ==1:
			$AnimatedSprite2D/Hitbox/CollisionShape2D.queue_free()
			x=2
			print(x)
func _on_timer_timeout():
	$AnimatedSprite2D.play("opened")
