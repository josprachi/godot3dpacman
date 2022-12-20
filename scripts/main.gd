extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for enem in get_tree().get_nodes_in_group("Enemies"):
		enem.setTarget($playerbody)
		#$sfxplayer.stream=load("res://sounds/sfx_coin_cluster1.wav")
	pass # Replace with function body.

func setsfx(val):
	if val:
		$sfxplayer.stream=load("res://sounds/sfx_sounds_fanfare1.wav")
	else:
		$sfxplayer.stream=load("res://sounds/sfx_coin_cluster1.wav")
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


func _on_powerupTimer_timeout():
	print("powerup play music")
	pass # Replace with function body.
