extends AnimatedSprite2D


@export var removing :bool = false
@onready var collection = $Collectable
const collectionType : StringName = "Pets"

func _ready():
	randomize ()
	var petNum = randi_range(1, 4)
	self.play("Pet" + str(petNum))
