extends AnimatedSprite2D

@onready var actionFinder = $ActionFinder
@export var dialogueResourse : DialogueResource

var openDialog = preload("res://GameScenes/Dialogs/OpeningScene.dialogue")
var flagDialog = preload("res://GameScenes/Dialogs/Flag.dialogue")
const interactableType = "Flag"

signal changeScene()

func _ready():
	play("flying")

func _unhandled_input(event):
	if Input.is_action_just_pressed("Talk"):
		var actionables = actionFinder.get_overlapping_areas()
		if actionables && actionables.size() > 0:
			Talk()
	pass

func Talk():
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	
	await get_tree().create_timer(0.4).timeout
	var curQuest = Global.quests[Global.currentQuest]
	
	if Global.currentQuest == "Quest3" || Global.currentQuest == "Pets":
		DialogueManager.show_example_dialogue_balloon(flagDialog, "FindTarget")
	else:
		DialogueManager.show_example_dialogue_balloon(dialogueResourse, Global.currentQuest)
	pass
	
func _on_dialogue_ended(_resource: DialogueResource):
	DialogueManager.dialogue_ended.disconnect(_on_dialogue_ended)
	
	await get_tree().create_timer(0.4).timeout
	if Global.previousQuest && Global.previousQuest != "":		
		var curQuest = Global.quests[Global.previousQuest]
		if(curQuest && "QuestComplete" in curQuest):
			if curQuest.QuestComplete:
				changeScene.emit()
