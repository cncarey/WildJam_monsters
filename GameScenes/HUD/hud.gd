extends CanvasLayer

@onready var QuestItemCount = $CurQuestItemCount
@onready var itemPic = $TextureHolder
@onready var DayCount = $DayCount
@onready var Banner = $Banner
@onready var CurQuestItemCount = $CurQuestItemCount

@onready var QuestName = $CurQuestName
@onready var QuestInstructions = $CurQuestInstuctions

var BlueDiamond = preload("res://Assets/Treasure Hunters/Pirate Treasure/Sprites/Blue Diamond/01.png")
var RedDiamond = preload("res://Assets/Treasure Hunters/Pirate Treasure/Sprites/Red Diamond/01.png")

func _ready():
	Banner.visible = false
	CurQuestItemCount.visible = false
	pass

#TODO load up the sprite
func updateHUDQuest():
	var curQuest = Global.quests[Global.currentQuest]
	
	if "QuestItem" in curQuest:
		Banner.visible = true
		CurQuestItemCount.visible = true
		CurQuestItemCount.text = str(0)
		
		match curQuest.QuestItem:
			"Red Diamond" :
				itemPic.texture = RedDiamond
			"Blue Diamond":
				itemPic.texture = BlueDiamond
		
	QuestInstructions.text =  curQuest.QuestInstructions
	QuestName.text = curQuest.QuestName

func updateItemCount(score):
	QuestItemCount.text = str(score)
	
func updateDayCount(day):
	DayCount.text = str(day)
	
	
