extends CharacterBody2D
var open = false

func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		if body.keyObtained and !open: 
			body.keyObtained = false
			$AnimatedSprite2D.play("opening")
			open = true
			print(get_node("hitbox").is_disabled() )
			get_node("hitbox").disabled = true 
			print(get_node("hitbox").is_disabled() )

func _on_area_2d_body_exited(_body):
	$AnimatedSprite2D.play("opened")

