extends CanvasLayer


func _ready():
	self.hide()

	
func game_win():
	get_tree().paused = true
	self.show()


func _on_play_again_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
