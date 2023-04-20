extends CharacterBody2D

signal startQuest(type)

var questStarted : bool = false
var questFinished : bool = false

var climbing = false

const speed = 300;
const jumpVolocity = -400
const maxJumps = 2
var curJumps = 0

@export var jumpmaxoffset : float = 0

const canFollow = true;

@onready var animation = $AnimatedSprite2D
@onready var actionFinder = $ActionFinder

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var curDirction = 0

@export var dialogueResourse : DialogueResource

func _ready():
	animation.play("idle")
	# Make sure to not await during _ready.
	call_deferred("actor_setup")

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame
	set_physics_process(false)
	
func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta
		animation.play("jump")
	else:
		curJumps = 0
	
	follow(delta)
	move_and_slide()

func canJump():
	if is_on_floor() && is_on_wall():
		return true
	else:
		return false

var FarFollowSpeed = 55
var CloseFollowSpeed = 25
var followDistance = 25
var followStopDistance = 70
var whatToFollow = null

func _unhandled_input(event):
	if Input.is_action_just_pressed("Talk"):
		var actionables = actionFinder.get_overlapping_areas()
		if actionables && actionables.size() > 0:
			Talk()
	pass

func startFollow(newWhatToFollow):
	whatToFollow = newWhatToFollow
	set_physics_process(true)
	
func stopFollow():
	whatToFollow = null
	animation.play("idle")
	set_physics_process(false)

func follow(delta):
	if(whatToFollow && self.position.distance_to(whatToFollow.position) > followDistance):
		#touchIndicator.visible = false
		
		var distance = Vector2(whatToFollow.position - self.position )
		
		var curFollowSpeed = FarFollowSpeed if (self.position.distance_to(whatToFollow.position) > followDistance * 2) else CloseFollowSpeed 
		var desiredVelocity = curFollowSpeed * distance.normalized()
		if distance.x == 0:
			animation.play("idle")
		else:
			animation.play("run")
			if  distance.x < 0 :
				animation.flip_h = true
			elif distance.x > 0:
				animation.flip_h = false
		
		
		if climbing:
			animation.play("idle")
			velocity.y = 0
			if distance.y < 0:
				velocity.y = -speed / (curFollowSpeed /8)
			elif distance.y > 0:
				velocity.y = speed / (curFollowSpeed / 8)
		else:
			pass
		
		if canJump():
			velocity.y = jumpVolocity
			animation.play("jump")
		
		
		var steering = (desiredVelocity - velocity) * delta *2.5
		velocity += steering
		
		move_and_slide()

func Talk():
	await get_tree().create_timer(0.4).timeout
	DialogueManager.show_example_dialogue_balloon(dialogueResourse, "Start")
	pass
