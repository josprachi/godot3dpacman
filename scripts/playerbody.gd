extends KinematicBody

# How fast the player moves in meters per second.
export var speed = 15
export var jump_impulse = 20

# The downward acceleration when in the air, in meters per second squared.
export var fall_acceleration = 75

var lifevalue=500
var velocity = Vector3.ZERO
var mouseDelta= Vector2()
var mouse_Sensitivity=0.002
func _process(delta):
	pass
func get_input():
	# We create a local variable to store the input direction.
	var direction = Vector3.ZERO
	if Input.get_mouse_mode()==Input.MOUSE_MODE_CAPTURED:
		var iputdir=Vector3.ZERO
		if Input.is_action_pressed("moveright"):
			iputdir.x -= 1		
		if Input.is_action_pressed("moveleft"):
			iputdir.x+= 1
		if Input.is_action_pressed("movedown"):      
			iputdir.z -= 1
		if Input.is_action_pressed("moveup"):
			iputdir.z += 1
		
		var forw=global_transform.basis.z
		var right= global_transform.basis.x
		var relativeDire= (forw*iputdir.z)+(right*iputdir.x)	
		direction=relativeDire
		if direction != Vector3.ZERO:
			direction = direction.normalized()
	else:			
		if Input.is_action_pressed("moveright"):
			direction += Vector3.RIGHT		
		if Input.is_action_pressed("moveleft"):
			direction+= Vector3.LEFT
		if Input.is_action_pressed("movedown"):      
			direction += Vector3.BACK
		if Input.is_action_pressed("moveup"):
			direction += Vector3.FORWARD
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
#	if event is InputEventMouseMotion and Input.get_mouse_mode()==Input.MOUSE_MODE_CAPTURED:
#		rotate_x(-event.relative.y*mouse_Sensitivity)
#		rotation.x= clamp(rotation.x,-1.0,1.0)					
				
func _physics_process(delta):
	if lifevalue>0:
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
				
				if collision.collider.isscred:
					collision.collider.hide()
				else:
					lifevalue-=1
			#collider.
	else:
		get_parent().gameover=true
		get_parent().showInstructions()		
