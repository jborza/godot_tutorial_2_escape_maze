extends "res://character/Character.gd"

signal moved
signal dead
signal grabbed_key
signal win

func _ready():
	pass

func _process(delta):
	if can_move:
		for dir in moves.keys():
			if Input.is_action_pressed(dir):
				if move(dir):
					emit_signal("moved")
					$FootstepsPlayer.play()

func _on_Player_area_entered(area):
	if area.is_in_group('enemies'):
		emit_signal('dead')
	if area.has_method('pickup'):
		area.pickup()
		match area.type:
			'key_red', 'key_green':
				emit_signal('grabbed_key',area.type)
			'star':			
				$WinPlayer.play()
				$CollisionShape2D.disabled = true
				yield($WinPlayer, 'finished')
				emit_signal('win')