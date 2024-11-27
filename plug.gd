# gdlint: disable=max-line-length
extends "res://addons/gd-plug/plug.gd"


func _plugging():
	# Declare plugins with plug(repo, args)
	# For example, clone from github repo("user/repo_name")
	plug("nathanhoad/godot_dialogue_manager")
	plug("nathanhoad/godot_sound_manager")
	# plug("imjp94/gd-YAFSM") # By default, gd-plug will only install anything from "addons/" directory
	# Or you can explicitly specify which file/directory to include
	# plug("imjp94/gd-YAFSM", {"include": ["addons/"]}) # By default, gd-plug will only install anything from "addons/" directory
