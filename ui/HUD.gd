extends CanvasLayer

func _ready():
	show_score()
	
func update_score(value):
	Global.score += value
	show_score()
	
func show_score():
	$MarginContainer/ScoreLabel.text = str(Global.score)