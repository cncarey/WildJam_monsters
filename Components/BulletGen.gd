class_name BulletGen
extends Node2D

var bulletScene = preload("res://Components/BulletComponent.tscn")
@export var bulletInterval: float

@onready var timer = $Timer

func _ready():
	timer.start(bulletInterval)

func _on_timer_timeout():
	var bulletNode = bulletScene.instantiate() as BulletComponent
	bulletNode.direction = Vector2.UP
	get_parent().add_child(bulletNode)
	timer.start(bulletInterval)
