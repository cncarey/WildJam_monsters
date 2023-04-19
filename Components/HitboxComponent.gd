class_name HitboxComponent
extends Area2D

signal hit_with_bullet(bullet)
signal hit(otherArea)

@onready var colShape = $CollisionShape2D

func _ready():
	pass	
	
func setColShape(_colShape):
	colShape = _colShape

func _on_area_entered(area: Area2D):
	if area.owner is BulletComponent:
		hit_with_bullet.emit(area.owner)
	else:
		hit.emit(area)
	pass # Replace with function body.
