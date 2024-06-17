extends Node2D

@export var weapon_name := 'Pistol'
var sprites = preload('res://assets/weapons/1.png')

# Give player the drop
func _ready():
	var sprite = get_node('Sprite2D')
	sprite.set_region_enabled(true)
	if weapon_name == 'Pistol':
		sprite.set_region_rect(Rect2(0, 118, 12, 10)) # takes a cutout of the sprites image (x, y, width, height)
	elif weapon_name == 'Shotgun':
		sprite.set_region_rect(Rect2(63, 82, 35, 15))
		
func _on_area_2d_body_entered(body):
	if body.has_method('player'):
		body.weapons[weapon_name] = true
		Global.set_gun_timer = true
		queue_free()
