class_name collectables
extends Area2D

@export var removing :bool = false
signal collected(itemCollected)
signal removedFromMiniMap(itemCollected)


func _on_body_entered(body):
	if body.is_in_group("Collector"):
		var p = get_parent()
		if "collectionType" in p:
			p.collection.collected.emit(p)
			p.collection.removedFromMiniMap.emit(p)
			pass
		else:
			assert("collectable is missing Name")	
		#TODO pass the parent to the player
		# and add it to the gloabl count#
		pass
	pass # Replace with function body.


func _on_body_exited(body):
	if body.is_in_group("Collector"):
		pass
	pass # Replace with function body.
