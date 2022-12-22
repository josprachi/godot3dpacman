extends KinematicBody

#export(Resource) var  playerNode
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 5
var direction =1
var roatated=false
var velocity =Vector3.ZERO
var playerTarget=null
var isscred=false
# Called when the node enters the scene tree for the first time.
func _ready():
	isscred=false
	$AnimationPlayer.stop()
	rotate_y(rand_range(-PI/4,PI/4))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func setTarget(target):
	self.playerTarget=target
func getAngry():
	print("angry")
	$AnimationPlayer.play("getAngry")
	yield($AnimationPlayer,"animation_finished")
	$AnimationPlayer.play("attack")
	
	
func scareenemy(value):
	self.isscred=value	
func _physics_process(delta):
	
	#if playerTarget:
	var player_position = playerTarget.global_transform.origin
	var direction_to_target=(player_position - self.global_transform.origin).normalized() 
	look_at_from_position(self.transform.origin,player_position,Vector3.UP)	
		
		
		
	for index in range(get_slide_count()):
		var collision= get_slide_collision(index)
		#if collision.collider.is_in_group("stage"):
			#direction*=-1
	velocity+= direction_to_target*delta*speed#*direction		
	velocity=move_and_slide(velocity)		
