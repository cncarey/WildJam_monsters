extends Node2D


@export var dialogueResourse : DialogueResource
@onready var youWin = $YouWin
@onready var anima = $AnimationPlayer

func _ready():
	
	if Global.quests.Complete:
		youWin.visible
	else:
		match Global.currentQuest:
			"Quest1":
				anima.play("Quest1_Enter")
			"Quest2","Quest3":
				anima.play("Quest2_Enter")
				
		DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	
		await get_tree().create_timer(0.4).timeout
		DialogueManager.show_example_dialogue_balloon(dialogueResourse, Global.currentQuest)
	pass
	
func _on_dialogue_ended(_resource: DialogueResource):
	DialogueManager.dialogue_ended.disconnect(_on_dialogue_ended)
	await get_tree().create_timer(0.4).timeout
	get_tree().change_scene_to_file("res://GameScenes/Land.tscn")

func playAnimation(toPlay):
	anima.play(toPlay)
