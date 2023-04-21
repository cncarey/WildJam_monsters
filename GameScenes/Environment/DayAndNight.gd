extends StaticBody2D

var state = Global.TimeOfDay.Day

var ChangeState = false

@export var LenghtOfDay = 45
@export var LenghtOfNight = 15

@onready var animation = $AnimationPlayer
@onready var timer = $Timer

signal nextDay()
signal day()
signal night()

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
	day.emit()
	#TODO emit update day
	
func changeToNight():
	animation.play("DayToNight")
	timer.start(LenghtOfNight)
	night.emit()

func pauseTimer():
	timer.paused = true
	
func restartTimer():
	timer.paused = false
