extends Node2D
var path_scene = "/mnt/data/Parasite/Parasite/scene/Objects/desk_note.gd"

var note_text_visible = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$NoteText.visible = note_text_visible


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if Input.is_action_just_pressed("interact"):
		note_text_visible.visible = true
		
