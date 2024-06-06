extends CharacterBody2D
var open = false

func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		if body.keyObtained and !open: 
			body.keyObtained = false
			$AnimatedSprite2D.play("opening")
			open = true
			get_node("hitbox").set_disabled(true)
			print(get_node("hitbox").is_disabled())

func _on_area_2d_body_exited(_body):
	$AnimatedSprite2D.play("opened")

# Identifier method
func door():
	pass
