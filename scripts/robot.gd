extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed = 5
export var jump_impulse = 40
var velocity = Vector3.ZERO
export var fall_acceleration = 75
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	print("XYZ")
#	pass
func _physics_process(delta):
	var direction = Vector3.ZERO
	if Input.is_action_pressed("moveright"):
		direction.x += 1
	if Input.is_action_pressed("moveleft"):
		direction.x -= 1
	
	if Input.is_action_pressed("movedown"):      
		direction.z += 1
	if Input.is_action_pressed("moveup"):
		direction.z -= 1
			
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	velocity.y -= fall_acceleration * delta
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		print("jump")
		velocity.y += jump_impulse	

	if direction != Vector3.ZERO:
		direction = direction.normalized()
	
	velocity = move_and_slide(velocity, Vector3.UP)
	pass
