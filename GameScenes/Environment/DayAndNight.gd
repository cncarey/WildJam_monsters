extends StaticBody2D

var state = Global.TimeOfDay.Day

var ChangeState = false

@export var LenghtOfDay = 15
@export var LenghtOfNight = 8

@onready var animation = $AnimationPlayer
@onready var timer = $Timer

signal nextDay()

func _ready():
	if state == Global.TimeOfDay.Day:
		changeToDay()
	elif state == Global.TimeOfDay.Night:
		changeToNight()
	pass

func _on_timer_timeout():
	match state:
		Global.TimeOfDay.Day:
			state = Global.TimeOfDay.Night
			pass
		Global.TimeOfDay.Night:
			state = Global.TimeOfDay.Day
			pass
		_:
			assert("Time of day not set")
		
	ChangeState = true
	pass # Replace with function body.

func _process(delta):
	if ChangeState == true:
		ChangeState = false
		if state == Global.TimeOfDay.Day:
			nextDay.emit()
			changeToDay()
		elif state == Global.TimeOfDay.Night:
			changeToNight()
			pass
			
func changeToDay():
	animation.play("NightToDay")
	timer.start(LenghtOfDay)
	#TODO emit update day
	
func changeToNight():
	animation.play("DayToNight")
	timer.start(LenghtOfNight)

func pauseTimer():
	timer.paused = true
	
func restartTimer():
	timer.paused = false
