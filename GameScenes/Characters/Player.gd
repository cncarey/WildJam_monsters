extends CharacterBody2D

var climbing = false

const speed = 300;
const jumpVolocity = -400
const maxJumps = 2
var curJumps = 0

var followers = []
signal signalFollowers(player, curTouching, isStarting)

@onready var animation = $AnimatedSprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var curDirction = 0

func _ready():
	animation.play("idle")

func _physics_process(delta):
	
	if climbing:
		velocity.y = 0
		if Input.is_action_pressed("Up"):
			velocity.y = -speed
		elif Input.is_action_pressed("Down"):
			velocity.y = speed
	else:
		pass
	
	if not is_on_floor():
		velocity.y += gravity * delta
		animation.play("jump")
	else:
		curJumps = 0
	
	if Input.is_action_just_pressed("Jump") && curJumps < maxJumps:
		velocity.y = jumpVolocity
		curJumps += 1
	
	var direction = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	
	if direction:
		curDirction = direction
		velocity.x = direction * speed
		animation.flip_h = curDirction < 0
		animation.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		animation.flip_h = curDirction < 0
		animation.play("idle")
	
	startFollow()
	stopFollow()
	move_and_slide()
	
func startFollow():
	if isTouching && Input.is_action_just_pressed("select"):
		
		for key in curTouching:
			curFollowing[key] = curTouching[key]
		
		signalFollowers.emit(self, curTouching, true)
		pass #TODO check if there is something in the touching block

#TODO figure out how to allow selecting what to stop following
func stopFollow():
	if Input.is_action_just_pressed("cancel"):
		if curFollowing.is_empty() == false:
			signalFollowers.emit(self, curFollowing, false)		
			curFollowing = {}

var isTouching : bool = false
var curTouching : Dictionary = {}
var curFollowing : Dictionary = {}
func _on_touch_area_body_entered(body):
	if(body != self && "canFollow" in body ): 
		isTouching = true
		curTouching[body.owner]= body
	pass # Replace with function body.


func _on_touch_area_body_exited(body):
	if("canFollow" in body) && curTouching.has(body.owner):
		curTouching.erase(body.owner)
		#If ther is nothig else touching hide emote
		isTouching = false
	
	pass # Replace with function body.
