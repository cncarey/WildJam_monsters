extends MarginContainer

#node path to player
@export var zoom = 1.5
@export var player = NodePath()
@onready var paper = $MarginContainer/Paper
@onready var playerMarker = $MarginContainer/Paper/Player
@onready var key = $MarginContainer/Paper/key

var paperScale 
var markers = {"key" : key}

func _ready():
	playerMarker.position.x = (self.size.x/2) - (playerMarker.texture.get_width()/2)
	playerMarker.position.y = (self.size.y/2) - (playerMarker.texture.get_height()/2)
	paperScale = paper.size/ (get_viewport_rect().size * zoom)


func _process(delta):
	if player:
		playerMarker.flip_h = player.animation.flip_h
		pass
	else:
		return
	
