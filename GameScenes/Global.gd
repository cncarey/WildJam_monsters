extends Node
enum TimeOfDay {Day, Night}
enum GameDifficulty {Easy, Med, Hard}
enum GameMode {Story, Endless}

@onready var day : Dictionary = {}
@onready var currentQuest = "Quest1"
@onready var curLevelComplete = false
@onready var previousQuest = ""
@onready var playerName = "Player"
@onready var isTalking = false

@onready var quests : Dictionary = {}

@onready var gameOptions : Dictionary = {
	"GameDifficulty" : GameDifficulty.Easy,
	"GameMode" : GameMode.Story
}

func resetDay():{
	day = {
	"State" : TimeOfDay.Day,
	"Day" : 1
}
}

func resetGameValues():
	currentQuest = "Quest1"
	previousQuest = ""
	isTalking = false
	quests = {
	"Complete" : false,
	"Quit": false,
	"Maps" : {
		"Q1" : false,
		"Q2" : false,
		"Q3" : false,
		"Q4" : false
	},
	"Morality" : 0,
	"Quest1" :{
		"QuestStarted" :  false,
		"QuestName" : "Find the Giant Crab",
		"QuestInstructions" : "-Find the Crab down below",
		"MaxDays": 5,
		"QuestComplete": false,
		"QuestCurDay": 0
	},
	"Crab" : {
		"QuestStarted" :  false,
		"QuestName" : "Lost Rubies",
		"QuestInstructions" : "-Find all ___ the Giant Crab's rubies",
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
		"QuestInstructions" : "-Find the Shark by the lake",
		"MaxDays": 10,
		"QuestComplete": false
	},
	"Shark" : {
		"QuestStarted" :  false,
		"QuestName" : "Lost Diamonds",
		"QuestInstructions" : "-Find all ___ of the Giant Shark's diamonds",
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
		"QuestInstructions" : "-Find all the pets",
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
		"QuestInstructions" : "-Find the Cave of Treasure",	
		"QuestComplete": false,
		"QuestCurDay": 0
	},
	"StarFish" : {
		"QuestStarted" :  false,
		"QuestName" : "Lost Diamonds",
		"QuestInstructions" : "-Find all ___ of the Giant Starfish's diamonds",
		"QuestItem" : "Blue Diamond",
		"CurrQuestItemCount" : 0,
		"CurrQuestKeyCount" : 0,
		#TODO set this based on the difficulty	
		"StandAloneItemCount" : 8, 
		"KeyedItemCount" : 3,
		"totalItems" : 11,
		"MaxDays": 10,
		"QuestComplete": false,
		"QuestCurDay": 0
	}
}
	
	day = {
	"State" : TimeOfDay.Day,
	"Day" : 0
	}
