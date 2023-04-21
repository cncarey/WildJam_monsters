extends Node2D

var blueDiamond = preload("res://GameScenes/Objects/Collectables/BlueDiamond.tscn")
var redDiamond = preload("res://GameScenes/Objects/Collectables/RedDiamond.tscn")
var key = preload("res://GameScenes/Objects/Collectables/key.tscn")

@onready var easyCollectablePoints = $EasyCollectables
@onready var standAlonePoint = $StandAloneCollectables
@onready var keyPoints = $KeyCollectionPair

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
	HUD.updateHUDQuest()
	
	var curQuest = Global.quests[Global.currentQuest]
	if(curQuest && "MaxDays" in curQuest):
		var questTime = (HUDDayNight.LenghtOfDay + HUDDayNight.LenghtOfNight) * curQuest.MaxDays
		questTimer.start(questTime)
		pass
	
	if "StandAloneItemCount" in curQuest:
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
		var keyedPoints = pick_rand_number(keyPoints.get_children(), curQuest.KeyedItemCount)
		for kP in keyedPoints :
			spawnCollectable(key.instantiate(), kP)
			print(kP.name)
			print(kP.get_child_count())
			
	if "easyCollectablePoints" in curQuest:
		for p in easyCollectablePoints.get_children():
			match type:
				"Blue Diamond":
					spawnCollectable(blueDiamond.instantiate(), p)
				"Red Diamond":
					spawnCollectable(redDiamond.instantiate(), p)
				_:
					assert("do not have a collectabnle of passed type preloaded")
		pass

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
	if Global.collectables.has(itemCollected.collectionType) && !itemCollected.removing:
		Global.collectables[itemCollected.collectionType] += 1
		var curQuest = Global.quests[Global.currentQuest]
		if(curQuest):
			curQuest.CurrQuestItemCount += 1
			pass
		
		HUD.updateItemCount(Global.collectables[itemCollected.collectionType])
		
		itemCollected.removing = true
		remove_child(itemCollected)
		pass
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
