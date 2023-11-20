extends CharacterBody2D

const ACCELERATION = 500.0 
const MAX_SPEED = 80.0
const FRICTION = 500.0

enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE

@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			pass
		ATTACK:
			attack_state()
	
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized() 
	
	if input_vector != Vector2.ZERO:
		animation_tree.set("parameters/Idle/blend_position", input_vector)
		animation_tree.set("parameters/Run/blend_position", input_vector)
		animation_tree.set("parameters/Attack/blend_position", input_vector)
		animation_tree.get("parameters/playback").travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animation_tree.get("parameters/playback").travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta) 
 
	#print(velocity)
	move_and_slide()
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK

func attack_state():
	animation_tree.get("parameters/playback").travel("Attack")
	
func attack_is_finished():
	state = MOVE
	
	
