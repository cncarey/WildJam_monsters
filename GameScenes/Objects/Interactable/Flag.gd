extends AnimatedSprite2D

@onready var actionFinder = $ActionFinder

func _ready():
	play("flying")

func _unhandled_input(event):
	if Input.is_action_just_pressed("Talk"):
		var actionables = actionFinder.get_overlapping_areas()
		if actionables && actionables.size() > 0:
			actionables[0].action("Start_Flag")
	pass
