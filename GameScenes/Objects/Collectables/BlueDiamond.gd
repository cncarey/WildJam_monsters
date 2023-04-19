extends AnimatedSprite2D

@export var removing :bool = false
@onready var collection = $Collectable
const collectionType : StringName = "Blue Diamond"

func _ready():
	self.play("default")
