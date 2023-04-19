extends Node
enum TimeOfDay {Day, Night}
enum GameDifficulty {Easy, Med, Hard}
enum GameMode {Story, Endless}

@onready var collectables : Dictionary = { 
	"Blue Diamond" : 0,
	"Blue Potion" : 0,
	"Gold Coin" : 0,
	"Green Bottle" : 0,
	"Green Diamond" : 0,
	"Red Diamond" : 0,
	"Red Potion" : 0
}

@onready var day : Dictionary = {
	"State" : TimeOfDay.Day,
	"Day" : 0
}
@onready var currentQuest = ""

@onready var quests : Dictionary = {
	"Find Crab" :{
		"QuestStarted" :  false,
		"QuestName" : "Find the Giant Crab",
		"QuestInstructions" : "Find the Crab down below",
		"MaxDays": 5
	},
	"Crab" : {
		"QuestStarted" :  false,
		"QuestItem" : "Red Diamond",
		"QuestName" : "Lost Rubies",
		"QuestInstructions" : "Find all the Giant Crab's rubies",
		"CurrQuestItemCount" : 0,
		"RequiredItemCount" : 5, #TODO set this based on the difficulty
		"MaxDays": 5
	},
	"Shark" : {}
}

@onready var gameOptions : Dictionary = {
	"GameDifficulty" : GameDifficulty.Easy,
	"GameMode" : GameMode.Story
}




func resetGameValues():
	quests = {
		"Crab" : {
			"QuestStarted" :  false,
			"QuestItem" : "Red Diamond",
			"CurrQuestItemCount" : 0,
			"RequiredItemCount" : 5, #TODO set this based on the difficulty
			"MaxDays": 5
		},
		"Shark" : {}
	}
	collectables = { 
	"Blue Diamond" : 0,
	"Blue Potion" : 0,
	"Gold Coin" : 0,
	"Green Bottle" : 0,
	"Green Diamond" : 0,
	"Red Diamond" : 0,
	"Red Potion" : 0
	}
	day = {
	"State" : TimeOfDay.Day,
	"Day" : 0
	}
