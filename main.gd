extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	#print("input")
	if Input.is_action_pressed("startgame"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		$Camera.current=false
		$playerbody/pivote/Camera.current=true
	if Input.is_action_pressed("leavegame"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$Camera.current=true
		$playerbody/pivote/Camera.current=false	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
