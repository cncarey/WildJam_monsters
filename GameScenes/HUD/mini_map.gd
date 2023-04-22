extends MarginContainer

#node path to player
@export var zoom = 1.5
@export var player = NodePath()
@onready var paper = $MarginContainer/Paper
@onready var playerMarker = $MarginContainer/Paper/Player
@onready var key = $MarginContainer/Paper/key
@onready var item = $MarginContainer/Paper/item
@onready var flag = $MarginContainer/Paper/Flag

var paperScale 

var markers = {}
@export var icons = {}

func _ready():
	icons = {
	"Key" : key,
	"Blue Diamond" : item,
	"Red Diamond" : item,
	"Chest" : item,
	"Flag" : flag
	}
	playerMarker.position.x = (self.size.x/2) - (playerMarker.texture.get_width()/2)
	playerMarker.position.y = (self.size.y/2) - (playerMarker.texture.get_height()/2)
	paperScale = paper.size/ (get_viewport_rect().size * zoom)

func updateMarkers():
	var mapObjects = get_tree().get_nodes_in_group("miniMap")
	
	print("in miniMap")
	var c = 0
	for mmItem in mapObjects:
		c += 1
		print(str(c))
		if !markers.has(mmItem):
			var newMarker = null
			
			if "collectionType" in mmItem:
				print(mmItem.collectionType)
				mmItem.collection.removedFromMiniMap.connect(removeIcon)
				newMarker = icons[mmItem.collectionType].duplicate()
			elif "interactableType" in mmItem:
				print(mmItem.interactableType)
				newMarker = icons[mmItem.interactableType].duplicate()
			
			if newMarker:
				paper.add_child(newMarker)
				newMarker.show()
				markers[mmItem] = newMarker
				
				print(newMarker)
	pass

func _process(delta):
	if player:
		playerMarker.flip_h = player.animation.flip_h
		pass
	else:
		return
	
	for item in markers:
		var iPos = (item.position - player.position) * paperScale
		var proX = ((self.size.x/2) - (playerMarker.texture.get_width()/2))
		var proY = ((self.size.y/2) - (playerMarker.texture.get_height()/2))
		iPos.x += proX
		iPos.y += proY
		
		iPos.x = clamp(iPos.x, 0, self.size.x)
		iPos.y = clamp(iPos.y, 0, self.size.y)
		
		#TODO if the position is off the map set the scale to .7,.7
		
		markers[item].position = iPos

func removeIcon(item):
	if markers.has(item):
		markers[item].hide()
		markers.erase(item)
