extends KinematicBody

# How fast the player moves in meters per second.
export var speed = 5
export var jump_impulse = 20
# The downward acceleration when in the air, in meters per second squared.
export var fall_acceleration = 75

var velocity = Vector3.ZERO

func _process(delta):
	pass
	
func _physics_process(delta):
	
	# We create a local variable to store the input direction.
	var direction = Vector3.ZERO

	# We check for each move input and update the direction accordingly.
	if Input.is_action_pressed("moveright"):
		direction.x += 1
	if Input.is_action_pressed("moveleft"):
		direction.x -= 1
	if Input.is_action_pressed("movedown"):      
		direction.z += 1
	if Input.is_action_pressed("moveup"):
		direction.z -= 1
	if direction != Vector3.ZERO:
		direction = direction.normalized()
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y += jump_impulse

	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	velocity.y -= fall_acceleration * delta
	velocity = move_and_slide(velocity, Vector3.UP)
	
#	for index in range(get_slide_count()):
#        # We check every collision that occurred this frame.
#		var collision = get_slide_collision(index)
#        # If we collide with a monster...
#		if collision.collider.is_in_group("mob"):
#			var mob = collision.collider
#            # ...we check that we are hitting it from above.
#            if Vector3.UP.dot(collision.normal) > 0.1:
#                # If so, we squash it and bounce.
#                mob.squash()
#                velocity.y = bounce_impulse


	#print(direction)
