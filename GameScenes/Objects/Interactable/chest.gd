extends StaticBody2D

@onready var isOpen = false
@onready var isTouched = false

@onready var animate = $AnimatedSprite2D

signal provideKey(this)

func _ready():
	animate.play("locked")
	pass
	
#return whether or not we use the key passed in
func tryOpenBox(hasKey):
	if hasKey && !isOpen:
		isOpen = true
		animate.play("opening")
		return true;
	return false;
		
func _on_animation_finished():
	if animate.animation == "opening" :
		animate.play("open")
	pass
	
func _on_body_entered(body):
	if body.is_in_group("Collector"):
		isTouched = true
	pass # Replace with function body.

func _unhandled_input(event):
	if Input.is_action_just_pressed("Talk") && isTouched:
		provideKey.emit(self)

func _on_body_exited(body):
	if body.is_in_group("Collector"):
		isTouched = false
	pass # Replace with function body.
