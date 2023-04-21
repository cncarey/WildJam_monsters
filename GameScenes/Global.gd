extends Node
enum TimeOfDay {Day, Night}
enum GameDifficulty {Easy, Med, Hard}
enum GameMode {Story, Endless}

@onready var day : Dictionary = {
	"State" : TimeOfDay.Day,
	"Day" : 0
}
@onready var currentQuest = "Quest2"
@onready var previousQuest = "Crab"

@onready var quests : Dictionary = {
	"Morality" : 0,
	"Quest1" :{
		"QuestStarted" :  false,
		"QuestName" : "Find the Giant Crab",
		"QuestInstructions" : "Find the Crab down below",
		"MaxDays": 10,
		"QuestComplete": false,
		"QuestCurDay": 0
	},
	"Crab" : {
		"QuestStarted" :  false,
		"QuestName" : "Lost Rubies",
		"QuestInstructions" : "Find all ___ the Giant Crab's rubies",
		"QuestItem" : "Red Diamond",
		"CurrQuestItemCount" : 0,
		#TODO set this based on the difficulty	
		"easyCollectablePoints" : 5, 
		"totalItems" : 5,
		"QuestComplete": false,
		"QuestCurDay": 0
	},
	"Quest2" : {
		"QuestStarted" :  false,
		"QuestName" : "Find the Giant Shark",
		"QuestInstructions" : "Find the Shark by the lake",
		"MaxDays": 20,
		"QuestComplete": false
	},
	"Shark" : {
		"QuestStarted" :  false,
		"QuestName" : "Lost Diamonds",
		"QuestInstructions" : "Find all ___ of the Giant Shark's diamonds",
		"QuestItem" : "Blue Diamond",
		"CurrQuestItemCount" : 0,
		"CurrQuestKeyCount" : 0,
		#TODO set this based on the difficulty	
		"StandAloneItemCount" : 5, 
		"KeyedItemCount" : 2,
		"totalItems" : 7,
		"QuestComplete": false,
		"QuestCurDay": 0
	},
	"Quest3" : {
		"QuestStarted" :  false,
		"QuestName" : "Find the Pets",
		"QuestInstructions" : "Find the Crab down below",
		"QuestItem" : "Pets",
		"CurrQuestItemCount" : 0,
		"CurrQuestKeyCount" : 0,
		"StandAloneItemCount" : 3, 
		"totalItems" : 3,
		"MaxDays": 10,
		"QuestComplete": false,
		"QuestCurDay": 0
	},
	"Quest4" : {
		"QuestStarted" :  false,
		"QuestName" : "Find the Cave of Treasure",
		"QuestInstructions" : "Find the Cave of Treasure",
		"MaxDays": 10,
		"QuestComplete": false,
		"QuestCurDay": 0
	}
}

@onready var gameOptions : Dictionary = {
	"GameDifficulty" : GameDifficulty.Easy,
	"GameMode" : GameMode.Story
}




func resetGameValues():
	quests = {
	"Morality" : 0,
	"Quest1" :{
		"QuestStarted" :  false,
		"QuestName" : "Find the Giant Crab",
		"QuestInstructions" : "Find the Crab down below",
		"MaxDays": 10,
		"QuestComplete": false,
		"QuestCurDay": 0
	},
	"Crab" : {
		"QuestStarted" :  false,
		"QuestName" : "Lost Rubies",
		"QuestInstructions" : "Find all ___ the Giant Crab's rubies",
		"QuestItem" : "Red Diamond",
		"CurrQuestItemCount" : 0,
		#TODO set this based on the difficulty	
		"easyCollectablePoints" : 5, 
		"totalItems" : 5,
		"QuestComplete": false,
		"QuestCurDay": 0
	},
	"Quest2" : {
		"QuestStarted" :  false,
		"QuestName" : "Find the Giant Shark",
		"QuestInstructions" : "Find the Shark by the lake",
		"MaxDays": 20,
		"QuestComplete": false
	},
	"Shark" : {
		"QuestStarted" :  false,
		"QuestName" : "Lost Diamonds",
		"QuestInstructions" : "Find all ___ of the Giant Shark's diamonds",
		"QuestItem" : "Blue Diamond",
		"CurrQuestItemCount" : 0,
		"CurrQuestKeyCount" : 0,
		#TODO set this based on the difficulty	
		"StandAloneItemCount" : 5, 
		"KeyedItemCount" : 2,
		"totalItems" : 7,
		"QuestComplete": false,
		"QuestCurDay": 0
	},
	"Quest3" : {
		"QuestStarted" :  false,
		"QuestName" : "Find the Pets",
		"QuestInstructions" : "Find the Crab down below",
		"QuestItem" : "Pets",
		"CurrQuestItemCount" : 0,
		"CurrQuestKeyCount" : 0,
		"StandAloneItemCount" : 3, 
		"totalItems" : 3,
		"MaxDays": 10,
		"QuestComplete": false,
		"QuestCurDay": 0
	},
	"Quest4" : {
		"QuestStarted" :  false,
		"QuestName" : "Find the Cave of Treasure",
		"QuestInstructions" : "Find the Cave of Treasure",
		"MaxDays": 10,
		"QuestComplete": false,
		"QuestCurDay": 0
	}
}
	
	day = {
	"State" : TimeOfDay.Day,
	"Day" : 0
	}
