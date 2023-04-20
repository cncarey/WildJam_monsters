extends StaticBody2D

@onready var isLocked = true
@onready var isOpen = false

@onready var _Animation = $Animation
@onready var collider = $Area2D

func _ready():
	setState()
func _process(delta):
	pass
			
func unlock(hasKey):
	if isLocked:
		if hasKey :
			isLocked = false
			isOpen = true
			_Animation.play("Opening")
			return true
	else:
		if !isOpen:
			isOpen = true
			_Animation.play("Opening")
	return false
			
func setState():
	if isOpen:
		_Animation.play("Open")
		collider.hide()
	else: 
		_Animation.play("Closed")
		if !isLocked:
			collider.hide()
		else:
			collider.show()

func _on_animation_finished():
	if _Animation.animation == "Opening" || _Animation.animation == "Closing":
		setState()
	pass # Replace with function body.
