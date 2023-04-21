extends StaticBody2D

@onready var isOpen = false

@onready var animate = $AnimatedSprite2D

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
