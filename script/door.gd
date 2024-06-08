extends CharacterBody2D
@export var direction := 'right'
var open := false
var tp: Vector2

func _ready():
	if direction == 'right':
		tp = Vector2(1200,0)
	elif direction == 'left':
		tp = Vector2(-1200,0)
	elif direction == 'down':
		tp = Vector2(0,750)
	elif direction == 'up':
		tp = Vector2(0,-750)

func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		if body.keyObtained and !open: 
			#body.keyObtained = false
			$AnimatedSprite2D.play("opening")
			open = true
		if open:
			body.position += tp
			print(tp)
			
# Identifier method
func door():
	pass
