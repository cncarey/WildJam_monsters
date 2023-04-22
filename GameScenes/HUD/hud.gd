extends CanvasLayer

@onready var QuestItemCount = $CurQuestItemCount
@onready var itemPic = $TextureHolder
@onready var DayCount = $DayHolder/DayCount
@onready var Banner = $Banner
@onready var CurQuestItemCount = $CurQuestItemCount
@onready var curKeyCount = $KeyCount
@onready var keyLabel = $KeyLabel

@onready var QuestName = $CurQuestName
@onready var QuestInstructions = $CurQuestInstuctions

@onready var sun = $"DayHolder/Brightness-high"
@onready var moon = $"DayHolder/Moon-fill"

var BlueDiamond = preload("res://Assets/Treasure Hunters/Pirate Treasure/Sprites/Blue Diamond/01.png")
var RedDiamond = preload("res://Assets/Treasure Hunters/Pirate Treasure/Sprites/Red Diamond/01.png")
var Pets = preload("res://Assets/Free Street Animal Pixel Art/1 Dog/Icon.png")

func _ready():
	Banner.visible = false
	CurQuestItemCount.visible = false
	#isDay()
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
			"Pets":
				itemPic.texture = Pets
				itemPic.scale = Vector2(.75, .75)
		
	if "KeyedItemCount" in curQuest:
		curKeyCount.visible = true
		keyLabel.visible = true
		
	QuestInstructions.text =  curQuest.QuestInstructions
	QuestName.text = curQuest.QuestName

func updateItemCount(score):
	QuestItemCount.text = str(score)
	
func updateKeyCount(keysCount):
	curKeyCount.text = str(keysCount)
	
func updateDayCount(day):
	DayCount.text = str(day)

func isDay():
	if sun:
		sun.visible = true
	if moon:
		moon.visible = false
	pass

func isNight():
	if sun:
		sun.visible = false
	if moon:
		moon.visible = true
	pass
	
