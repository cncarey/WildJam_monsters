extends Node2D


@export var dialogueResourse : DialogueResource
@onready var youWin = $YouWin
@onready var anima = $AnimationPlayer

func _ready():
	
	if Global.quests.Complete:
		anima.play("YouWin")
		
	else:
		match Global.currentQuest:
			"Quest1":
				anima.play("Quest1_Enter")
			"Quest2","Quest3":
				anima.play("Quest2_Enter")
			"Quest4":
				anima.play("Quest4_Enter")
				
		DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	
		await get_tree().create_timer(0.4).timeout
		DialogueManager.show_example_dialogue_balloon(dialogueResourse, Global.currentQuest)
	pass
	
func _on_dialogue_ended(_resource: DialogueResource):
	DialogueManager.dialogue_ended.disconnect(_on_dialogue_ended)
	await get_tree().create_timer(0.4).timeout
	if Global.quests.Quit:
		get_tree().change_scene_to_file("res://GameScenes/HUD/StartMenu.tscn")
	else:
		get_tree().change_scene_to_file("res://GameScenes/Land.tscn")

func playAnimation(toPlay):
	anima.play(toPlay)

func _on_animation_player_animation_finished(anim_name):
	if Global.quests.Complete || Global.quests.Quit:
		get_tree().change_scene_to_file("res://GameScenes/HUD/StartMenu.tscn")
	pass # Replace with function body.
