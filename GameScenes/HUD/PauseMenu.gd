extends CanvasLayer

@onready var screen = $TextureRect
@onready var restartbutton = $VBoxContainer/Restart
@onready var isGameOver :bool = false
@onready var label = $VBoxContainer/Label

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
