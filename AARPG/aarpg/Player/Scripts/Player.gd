class_name Player extends CharacterBody2D

var speed: float = 100.0  # Define a speed variable
var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO

@onready var animation_tree: AnimationTree = $AnimationTree  # Corrected to AnimationTree
@onready var animation_state: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")

@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine

func _ready():
	state_machine.Initialize(self)
	animation_tree.active = true  # Ensure AnimationTree is active

func _process(_delta):
	# Get movement input from the player
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	# Normalize diagonal movement
	if direction.length() > 1:
		direction = direction.normalized()

func _physics_process(_delta):
	# Apply movement velocity and move the character
	velocity = direction * speed
	move_and_slide()

	# Update direction and animation if movement is detected
	if SetDirection():
		UpdateAnimation("walk")
	elif direction == Vector2.ZERO:
		UpdateAnimation("idle")

func SetDirection() -> bool:
	var new_dir: Vector2 = cardinal_direction
	if direction == Vector2.ZERO:
		return false

	if direction.y == 0:
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN

	if new_dir == cardinal_direction:
		return false

	cardinal_direction = new_dir
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true

func UpdateAnimation(state: String) -> void:
	animation_state.travel(state + "_" + AnimDirection())  # Use AnimationTree's state machine

func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
