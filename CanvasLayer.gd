extends CanvasLayer

# Variable to track whether the menu is active
var menu_active = false

func _ready():
	# Initially hide the menu
	hide()
	
	# Connect buttons to their functions

# Function to toggle the menu
func toggle_menu():
	if menu_active:
		hide()
		get_tree().paused = false
	else:
		show()
		get_tree().paused = true
	menu_active = !menu_active

# Button pressed functions
func _on_ResumeButton_pressed():
	toggle_menu()

func _on_OptionsButton_pressed():
	# Open options menu (implement your options logic here)
	print("Opening options...")

func _on_ExitButton_pressed():
	# Exit to main menu or quit the game
	get_tree().quit()
