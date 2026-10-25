extends Node
# Path prefix for new scenes to be added
const path_prefix = "res://scenes/"

# Function for switching scenes so it's unified globally
func switch_to_scene(path:String,name):
	# Get current scene, aka the hall the player chooses from
	var current = get_tree().current_scene
	
	# Check and confirm
	if current.name != "Game":
		
		# Full path : "res://scenes/folder_name/scene_name"
		var full_path = path_prefix + path
		
		# Confirm it exsists
		if not ResourceLoader.exists(full_path):
			return
		
		# Load scene and instantiate
		var scene:PackedScene = load(full_path)
		var instance = scene.instantiate()
		
		# Get canvas and make them layer 30
		for child in instance.get_children():
			if child is CanvasLayer:
				child.layer=30
		
		# Add child :D
		current.add_child(instance)

# Remove minigame scene
func end_minigame(name:String):
	# Confirm and remove :P
	var current = get_tree().current_scene
	if current.has_node(name):
		current.get_node(name).queue_free()
