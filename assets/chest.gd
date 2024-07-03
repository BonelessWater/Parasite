extends Node2D
var x = 0
var close = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$RichTextLabel.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.key_obtained and Global.key_amount >0:
		if Input.is_action_just_pressed("interact") and close == true and x==0:
			$AnimatedSprite2D.play("opening")
			Global.weapons['Pistol'] = true
			Global.set_gun_timer = true
			Global.key_obtained = false
			Global.key_amount =-1
			$AnimationTimer.start()
			x += 1
			$RichTextLabel.visible = true
			$Timer.start()
			

func _on_area_2d_body_entered(body):
	close = true


func _on_animation_timer_timeout():
	$AnimatedSprite2D.play("opened")


func _on_timer_timeout():
	$RichTextLabel.visible = false
	
