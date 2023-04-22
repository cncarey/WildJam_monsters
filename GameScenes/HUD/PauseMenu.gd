extends CanvasLayer

@onready var screen = $TextureRect
@onready var restartbutton = $VBoxContainer/Restart
@onready var isGameOver :bool = false
@onready var label = $VBoxContainer/Label

@onready var map1 = $TextureRect/MarginContainer/GridContainer/Map1
@onready var map2 = $TextureRect/MarginContainer/GridContainer/Map2
@onready var map3 = $TextureRect/MarginContainer/GridContainer/Map3
@onready var map4 = $TextureRect/MarginContainer/GridContainer/Map4


func _ready():
	for c in get_children():
		c.visible = false
	pass
	
func _input(event):
	if event.is_action_pressed("Pause") && !isGameOver:
		pause()

func pause():
	if isGameOver:
		label.text = "Game Over"
	else:
		label.text = "Paused"
	
	#Make a loop for this later
	if Global.quests.Maps.Q1:
		map1.show()
	else:
		map1.hide()
		
	if Global.quests.Maps.Q2:
		map2.show()
	else:
		map2.hide()
		
	if Global.quests.Maps.Q3:
		map3.show()
	else:
		map3.hide()	
		
	if Global.quests.Maps.Q4:
		map4.show()
	else:
		map4.hide()
	
	get_tree().paused = !get_tree().paused 
	for c in get_children():
		c.visible = !c.visible

func _on_restart_pressed():
	isGameOver = false
	Global.resetGameValues()
	get_tree().paused = false
	for c in get_children():
		c.visible = false
		
	get_parent().get_tree().reload_current_scene()
	pass

func _on_quit_game_pressed():
	get_tree().quit()
	pass

func gameOver():
	isGameOver = true
	pause()
