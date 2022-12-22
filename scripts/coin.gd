extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mainParent
var sfxplayer
export(bool) var isSpecial
var specialSfx= preload("res://sounds/sfx_sounds_fanfare1.wav")
var normalcoinsfx = preload("res://sounds/sfx_coin_cluster1.wav")
# Called when the node enters the scene tree for the first time.
func _ready():
	mainParent=get_parent().get_parent()
	sfxplayer=mainParent.get_node("sfxplayer")
	$AnimationPlayer.stop()
	mainParent.setsfx(self.isSpecial)
	if self.isSpecial:
		
		$AnimationPlayer.play("pecialRotate")
	else:	
		
		$AnimationPlayer.play("spin")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Coin_body_entered(body):	
	$AnimationPlayer.stop()
	if $MeshInstance.visible==true:
		if isSpecial:
			mainParent.score+=5
			mainParent.startEnemyTimer()
		
		else:
			mainParent.score+=1

	mainParent.setsfx(self.isSpecial)
	if sfxplayer.playing==false:
		sfxplayer.play()
	
	$MeshInstance.hide()
	
	pass # Replace with function body.
