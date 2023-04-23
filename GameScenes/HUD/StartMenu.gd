extends Control

@onready var playerName = $MarginContainer/VBoxContainer/PlayerName

func _on_new_game_pressed():
	Global.resetGameValues()
	get_tree().change_scene_to_file("res://GameScenes/CutScenes/OpeningScene.tscn")
	pass # Replace with function body.



func _on_quit_game_pressed():
	get_tree().quit()
	pass # Replace with function body.


func nameChanged():
	if playerName.text == "":
		Global.playerName = "Player"
	else:
		Global.playerName = playerName.text
	pass # Replace with function body.
