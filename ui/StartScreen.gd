extends Control

func _input(event):
	if event.is_action_pressed('ui_select'):
		Global.new_game()
		
func _ready():
	$HighScoreLabel.text = "High Score: " +str(Global.highscore)