extends CanvasLayer

@onready var QuestItemCount = $CurQuestItemCount
@onready var itemPic = $TextureHolder
@onready var DayCount = $DayHolder/DayCount
@onready var Banner = $Banner
@onready var CurQuestItemCount = $CurQuestItemCount

@onready var keyContainer = $KeyContainer
@onready var keyItem = $KeyIcon

@onready var QuestName = $CurQuestName
@onready var QuestInstructions = $CurQuestInstuctions
@onready var FlagInstructions = $FlagInstuctions

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
				itemPic.scale = Vector2(.7, .7)
		
	QuestInstructions.text =  curQuest.QuestInstructions
	QuestName.text = curQuest.QuestName
	
	updateDayCount(Global.day.Day)
	
	match Global.day.State:
		Global.TimeOfDay.Day:
			isDay()
		Global.TimeOfDay.Night:
			isNight()
		_:
			isDay()

func updateItemCount(score):
	QuestItemCount.text = str(score)
	var curQuest = Global.quests[Global.currentQuest]
	
	if "CurrQuestItemCount" in curQuest && "totalItems" in curQuest:
		if curQuest.CurrQuestItemCount >= curQuest.totalItems:
			FlagInstructions.visible = true
		pass
	
func updateKeyCount(keysCount):
	for k in keyContainer.get_children():
		k.free()
		
	for i in range(keysCount):
		var newKey = keyItem.duplicate()
		
		newKey.visible = true
		keyContainer.add_child(newKey)
	
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
	
