extends KinematicBody

export (PackedScene) var playerNode
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 5
var direction =1
var roatated=false
var velocity =Vector3.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	rotate_y(rand_range(-PI/4,PI/4))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func getAngry():
	print("angry")
	$AnimationPlayer.play("getAngry")
	yield($AnimationPlayer,"animation_finished")
	$AnimationPlayer.play("attack")
func _physics_process(delta):
	velocity+= Vector3.RIGHT*delta*speed
	#$AnimationPlayer.stop()
	
	move_and_slide(velocity)
	for index in range(get_slide_count()):
		var collision= get_slide_collision(index)
		if collision.collider.to_string().find("wall"):
			if roatated==false:
				direction*= -1
				#rotate_y(direction*PI)
				roatated=true
		
			#$AnimationPlayer.play("attack")
	
