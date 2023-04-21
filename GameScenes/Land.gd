extends Node2D

var blueDiamond = preload("res://GameScenes/Objects/Collectables/BlueDiamond.tscn")
var redDiamond = preload("res://GameScenes/Objects/Collectables/RedDiamond.tscn")
var key = preload("res://GameScenes/Objects/Collectables/key.tscn")
var chest = preload("res://GameScenes/Objects/Interactable/chest.tscn")

@onready var easyCollectablePoints = $EasyCollectables
@onready var standAlonePoint = $StandAloneCollectables
@onready var keyPoints = $KeyCollectionPair
@onready var chestPoints = $ChestPositions

@onready var HUD = $HUD
@onready var HUDDayNight = $HUD/DayAndNight
@onready var questTimer = $CurQuestTimer
@onready var pauseMenu = $PauseMenu

@onready var tutorial = $Tutorial
@onready var door = $Door

func _ready():
	if(Global.currentQuest == "Quest1" || Global.currentQuest == "Crab"):
		tutorial.visible = true
	else:
		tutorial.visible = false
		door.isLocked = false
		door.unlock(false)
	
	#get the current quest from globals and scyn the HUD
	var curQuest = Global.quests[Global.currentQuest]
	if(curQuest && "MaxDays" in curQuest):
		var questTime = (HUDDayNight.LenghtOfDay + HUDDayNight.LenghtOfNight) * curQuest.MaxDays
		questTimer.start(questTime)
		pass
	HUD.updateHUDQuest()
	pass

func startQuest(type : StringName, questName: StringName):
	#TODO randomly pick the number and which of points to use based on the difficulty set
	#TODO pass in which collectable the monster is requiring us to find
	#TODO return the number of easy items and keyed items so the monster can tell us in the chat
	Global.previousQuest = Global.currentQuest
	Global.currentQuest = questName
	
	var curQuest = Global.quests[Global.currentQuest]
	
	if(curQuest && "MaxDays" in curQuest):
		var questTime = (HUDDayNight.LenghtOfDay + HUDDayNight.LenghtOfNight) * curQuest.MaxDays
		questTimer.start(questTime)
		pass
	
	var TotalCount = 0;
	
	if "StandAloneItemCount" in curQuest:
		TotalCount += curQuest.StandAloneItemCount
		var standAlone = pick_rand_number(standAlonePoint.get_children(), curQuest.StandAloneItemCount)
		for saP in standAlone :
			match curQuest.QuestItem:
				"Blue Diamond":
					spawnCollectable(blueDiamond.instantiate(), saP)
				"Red Diamond":
					spawnCollectable(redDiamond.instantiate(), saP)
				_:
					assert("do not have a collectabnle of passed type preloaded")
					
	if "KeyedItemCount" in curQuest:
		TotalCount += curQuest.KeyedItemCount
		var keyedPoints = pick_rand_number(keyPoints.get_children(), curQuest.KeyedItemCount)
		for kP in keyedPoints :
			print(kP.name)
			spawnCollectable(key.instantiate(), kP)
			for cP in chestPoints.get_children():
				if cP.name == "_" + kP.name:
					var spawn = chest.instantiate();
					spawn.position = cP.position
					print(cP.name)
					print(spawn)
					add_child(spawn)
					spawn.provideKey.connect(provideKey)
				#TODO connect to open chest script
			
	if "easyCollectablePoints" in curQuest:
		TotalCount += easyCollectablePoints.get_child_count()
		for p in easyCollectablePoints.get_children():
			match type:
				"Blue Diamond":
					spawnCollectable(blueDiamond.instantiate(), p)
				"Red Diamond":
					spawnCollectable(redDiamond.instantiate(), p)
				_:
					assert("do not have a collectabnle of passed type preloaded")
		pass
	curQuest.QuestInstructions = curQuest.QuestInstructions.replace("___", str(TotalCount))
	HUD.updateHUDQuest()

func pick_rand_number(list: Array, amount: int) -> Array:
	randomize()
	list.shuffle()
	var new_list: Array = []

	assert(amount <= list.size(), "The number cannot be greater than the size of the Array")

	for i in range(amount):
		if new_list.size() <= amount:
			new_list.append(list[i])
	return new_list

func spawnCollectable(spawn, parent):
	spawn.position = parent.position
	add_child(spawn)
	spawn.collection.collected.connect(onItemCollected)
		
	pass

func _on_player_signal_followers(player, curTouching, isStarting):
	for key in curTouching:
		if isStarting:
			curTouching[key].startFollow(player)
		else:	
			curTouching[key].stopFollow()
	pass # Replace with function body.


func onItemCollected(itemCollected):
	print(itemCollected.collectionType)
	var curQuest = Global.quests[Global.currentQuest]
	if !itemCollected.removing && curQuest:
		if itemCollected.collectionType == curQuest.QuestItem:
			curQuest.CurrQuestItemCount += 1
			HUD.updateItemCount(curQuest.CurrQuestItemCount)
			
			itemCollected.removing = true
			remove_child(itemCollected)
			pass
		
		elif itemCollected.collectionType == "Key":			
			curQuest.CurrQuestKeyCount += 1
			HUD.updateKeyCount(curQuest.CurrQuestKeyCount)
			
			itemCollected.removing = true
			remove_child(itemCollected)
			
	#TODO if it is a key grab it and update the HUD
	pass # Replace with function body.

func set_Next_Day():
	Global.day["Day"] += 1
	HUD.updateDayCount(Global.day["Day"])
	pass
	
func pauseTimer():
	HUDDayNight.pauseTimer()
	
func restartTimer():
	HUDDayNight.restartTimer()

func toCutScene():
	get_tree().change_scene_to_file("res://GameScenes/CutScenes/OpeningScene.tscn")

func provideKey(chest):
	var curQuest = Global.quests[Global.currentQuest]
	if curQuest && curQuest.CurrQuestKeyCount && curQuest.CurrQuestKeyCount >= 1:
		if chest.tryOpenBox(true):
			curQuest.CurrQuestKeyCount -= 1
			HUD.updateKeyCount(curQuest.CurrQuestKeyCount)
			
			curQuest.CurrQuestItemCount += 1
			HUD.updateItemCount(curQuest.CurrQuestItemCount)
	pass
