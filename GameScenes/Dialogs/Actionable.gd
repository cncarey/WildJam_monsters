extends Area2D

@export var dialogueResourse : DialogueResource
@export var dialogueStart : StringName = "Find_Crab"

func action(start):
	DialogueManager.show_example_dialogue_balloon(dialogueResourse, start)
