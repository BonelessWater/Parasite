extends Node2D

# Just change these varaibles when making a new drop
var ability_name := 'Dash'
const image := preload('res://assets/items/crystal_01.png')

var sprite

func _ready():
	sprite = get_node('Sprite2D')
	sprite.texture = image

# Give player the drop
func _on_area_2d_body_entered(body):
	if body.has_method('player'):
		body.abilities[ability_name] = true
		queue_free()
