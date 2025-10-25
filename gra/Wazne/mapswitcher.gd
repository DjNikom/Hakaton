extends Node

var current_scene: Node
var root: Window

func _ready():
	root = get_tree().root
	# Using a negative index counts from the end, so this gets the last child node of `root`.
	current_scene = root.get_child(-1)

func goto_scene(path, point, door):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	current_scene = root.get_child(-1)

	_deferred_goto_scene.call_deferred(path, point, door)


func _deferred_goto_scene(path, point, door):
	var transition = ResourceLoader.load("res://Wazne/transition.tscn")
	current_scene.get_node("Frisk").add_child(transition.instantiate())
	current_scene.get_node("Frisk").set_meta("movable", false)
	var instancedTransition = current_scene.get_node("Frisk").get_node("Transition")
	instancedTransition.name = "outTransition"
	instancedTransition.color = Color(0, 0, 0, 0)
	instancedTransition.get_node("fadeout").play("fadeout")
	if door:
		var friskPos = current_scene.get_node("Frisk").position
		current_scene.get_node("Frisk").constVel = (door-friskPos)*2.5
	await get_tree().create_timer(0.75).timeout
	
	
	var gracz = ResourceLoader.load("res://Postacie/Player/player.tscn")

	# It is now safe to remove the current scene.
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instantiate()

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene
	
	get_tree().current_scene.add_child(gracz.instantiate())
	
	var spawnpos = get_tree().current_scene.get_node("spawns").get_node(point).position
	
	var gracz_node = get_tree().current_scene.get_node("Frisk")
	gracz_node.position = spawnpos
	gracz_node.po_wejsciu = 8
