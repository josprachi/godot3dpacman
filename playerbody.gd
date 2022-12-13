extends KinematicBody

# How fast the player moves in meters per second.
export var speed = 5
export var jump_impulse = 20
onready var camera = $pivot/Camera

# The downward acceleration when in the air, in meters per second squared.
export var fall_acceleration = 75

#var velocity = Vector3.ZERO

var gravity = -30
var max_speed = 8
var mouse_sensitivity = 0.002  # radians/pixel
var spin = 0.1
var velocity = Vector3()
var mouseDelta= Vector2()
func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass
func get_input():
	var direction = Vector3.ZERO
	# We check for each move input and update the direction accordingly.
	if Input.is_action_pressed("moveright"):
		direction+=Vector3.RIGHT
		#direction.x += 1
	if Input.is_action_pressed("moveleft"):
		direction+=Vector3.LEFT
		#direction.x -= 1
	if Input.is_action_pressed("movedown"):
		direction+=Vector3.BACK      
		#direction.z += 1
	if Input.is_action_pressed("moveup"):
		direction+=Vector3.FORWARD
		#direction.z -= 1
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$pivote.look_at(translation - direction,Vector3.UP)		
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y += jump_impulse
	return direction	
		
func _input(event):	
	if event is InputEventMouseMotion:
		mouseDelta = event.relative
		if event.relative.x > 0:
			rotate_y(-lerp(0, spin, event.relative.x/10))
		elif event.relative.x < 0:
			rotate_y(-lerp(0, spin, event.relative.x/10))
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		#rotate_y(-event.relative.x * mouse_sensitivity)
		$pivote.rotate_x(-event.relative.y * mouse_sensitivity)
		$pivote.rotation.x = clamp($pivote.rotation.x, -1.2, 1.2)	
			
func _physics_process(delta):
	velocity.y += gravity * delta
	var desired_velocity = get_input() * max_speed
	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	velocity = move_and_slide(velocity, Vector3.UP, true)
