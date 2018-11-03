extends "res://Character.gd"

signal moved
signal dead
signal grabbed_key
signal win

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if can_move:
		for dir in moves.keys():
			if Input.is_action_pressed(dir):
				if move(dir):
					emit_signal("moved")