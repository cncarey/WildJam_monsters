extends MarginContainer

#node path to player
@export var zoom = 1.5
@export var player = NodePath()
@onready var paper = $MarginContainer/Paper
@onready var playerMarker = $MarginContainer/Paper/Player
@onready var key = $MarginContainer/Paper/key
@onready var item = $MarginContainer/Paper/item
@onready var flag = $MarginContainer/Paper/Flag
@onready var crab = $MarginContainer/Paper/Crab
@onready var shark = $MarginContainer/Paper/Shark
@onready var starfish = $MarginContainer/Paper/Starfish

var paperScale 

var markers = {}
@export var icons = {}

func _ready():
	icons = {
	"Key" : key,
	"Blue Diamond" : item,
	"Red Diamond" : item,
	"Chest" : item,
	"Flag" : flag,
	"Pets" : item,
	"Crab" : crab,
	"Shark": shark,
	"StarFish" : starfish
	}
	playerMarker.position.x = (self.size.x/2) - (playerMarker.texture.get_width()/2)
	playerMarker.position.y = (self.size.y/2) - (playerMarker.texture.get_height()/2)
	paperScale = paper.size/ (get_viewport_rect().size * zoom)
	

func updateMarkers():
	var mapObjects = get_tree().get_nodes_in_group("miniMap")
	
	for mmItem in mapObjects:
		if !markers.has(mmItem):
			var newMarker = null
			
			if "collectionType" in mmItem:
				mmItem.collection.removedFromMiniMap.connect(removeIcon)
				newMarker = icons[mmItem.collectionType].duplicate()
			elif "interactableType" in mmItem:
				newMarker = icons[mmItem.interactableType].duplicate()
			elif "CharcterName" in mmItem && mmItem.visible:
				newMarker = icons[mmItem.CharcterName].duplicate()
				
			if newMarker:
				
				
				paper.add_child(newMarker)
				newMarker.show()
				markers[mmItem] = newMarker
				
	pass

func _process(delta):
	if player:
		playerMarker.flip_h = player.animation.flip_h
		pass
	else:
		return
	
	var vp = paper.get_viewport_rect()
	
	for item in markers:
		var iPos = (item.position - player.position) * paperScale
		var proX = ((self.size.x/2) - (playerMarker.texture.get_width()/2))
		var proY = ((self.size.y/2) - (playerMarker.texture.get_height()/2))
		iPos.x += proX
		iPos.y += proY
		
		iPos.x = clamp(iPos.x, 0, self.size.x)
		iPos.y = clamp(iPos.y, 0, self.size.y)
		
		#TODO if the position is off the map set the scale to .7,.7
		#TODO hold onto the base scale as not everything starts at scale 1,1
#		if vp.has_point(markers[item].position):
#			markers[item].scale = Vector2(1, 1)
#		else:
#			markers[item].scale = Vector2(.6, .6)
		
		markers[item].position = iPos

func removeIcon(item):
	if markers.has(item):
		markers[item].hide()
		markers.erase(item)
