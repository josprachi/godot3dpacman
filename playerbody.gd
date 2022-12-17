extends KinematicBody

# How fast the player moves in meters per second.
export var speed = 15
export var jump_impulse = 20

# The downward acceleration when in the air, in meters per second squared.
export var fall_acceleration = 75

var velocity = Vector3.ZERO
var mouseDelta= Vector2()
var mouse_Sensitivity=0.002
func _process(delta):
	pass
func get_input():
	# We create a local variable to store the input direction.
	var direction = Vector3.ZERO
	# We check for each move input and update the direction accordingly.
	if Input.is_action_pressed("moveright"):
		direction.x += 1		
	if Input.is_action_pressed("moveleft"):
		direction.x -= 1
		
		#translate_object_local(-transform.basis.x)
	if Input.is_action_pressed("movedown"):      
		direction.z += 1
	if Input.is_action_pressed("moveup"):
		direction.z -= 1
	if direction != Vector3.ZERO:
		direction = direction.normalized()
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y += jump_impulse
	return direction

func _input(event):
	if event is InputEventMouseMotion:
		mouseDelta=event.relative
		if event.relative.x>0:
			rotate_y(-lerp(0,0.1,event.relative.x/10))
		elif event.relative.x<0:
			rotate_y(-lerp(0,0.1,event.relative.x/10))
	if event is InputEventMouseMotion and Input.get_mouse_mode()==Input.MOUSE_MODE_CAPTURED:
		$pivote.rotate_x(-event.relative.y*mouse_Sensitivity)
		$pivote.rotation.x= clamp($pivote.rotation.x,-1.0,1.0)
					
				
func _physics_process(delta):
	var expectedVelocity= get_input()*speed 
	velocity.x = expectedVelocity.x
	velocity.z = expectedVelocity.z 
	velocity.y -= fall_acceleration * delta
	velocity = move_and_slide(velocity, Vector3.UP)
	for index in range(get_slide_count()):
		var collision= get_slide_collision(index)
		if collision.collider.is_in_group("Enemies"):
			#print("enemy")
			#collision.collider.hide()
			collision.collider.getAngry()
		#collider.
			
