extends Node2D

var blueDiamond = preload("res://GameScenes/Objects/Collectables/BlueDiamond.tscn")
var redDiamond = preload("res://GameScenes/Objects/Collectables/RedDiamond.tscn")
@onready var easyCollectablePoints = $EasyCollectables
@onready var HUD = $HUD
@onready var HUDDayNight = $HUD/DayAndNight
@onready var questTimer = $CurQuestTimer
@onready var pauseMenu = $PauseMenu

func _ready():
	pass

func startQuest(type : StringName, questName: StringName):
	#TODO randomly pick the number and which of points to use based on the difficulty set
	#TODO pass in which collectable the monster is requiring us to find
	#TODO return the number of easy items and keyed items so the monster can tell us in the chat
	Global.currentQuest = questName
	
	var curQuest = Global.quests[Global.currentQuest]
	if(curQuest):
		var questTime = (HUDDayNight.LenghtOfDay + HUDDayNight.LenghtOfNight) * curQuest.MaxDays
		questTimer.start(questTime)
		pass
	
	for p in easyCollectablePoints.get_children():
		match type:
			"Blue Diamond":
				spawnCollectable(blueDiamond.instantiate(), p)
			"Red Diamond":
				spawnCollectable(redDiamond.instantiate(), p)
			_:
				assert("do not have a collectabnle of passed type preloaded")
	pass

func spawnCollectable(spawn, parent):
	HUD.updateItem(spawn.collectionType)
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
		
		HUD.updateItem(itemCollected.collectionType)
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
