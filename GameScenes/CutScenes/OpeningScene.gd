extends Node2D

@export var dialogueResourse : DialogueResource
@onready var youWin = $YouWin

func _ready():
	
	if Global.quests.Complete:
		youWin.visible
	else:
		DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	
		await get_tree().create_timer(0.4).timeout
		DialogueManager.show_example_dialogue_balloon(dialogueResourse, Global.currentQuest)
	pass
	
func _on_dialogue_ended(_resource: DialogueResource):
	DialogueManager.dialogue_ended.disconnect(_on_dialogue_ended)
	await get_tree().create_timer(0.4).timeout
	get_tree().change_scene_to_file("res://GameScenes/Land.tscn")
