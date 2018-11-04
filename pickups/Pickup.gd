extends Area2D

var textures = {'coin':'res://assets/coin.png',
				'key_red':'res://assets/keyRed.png',
				'key_green':'res://assets/keyGreen.png',
				'star':'res://assets/star.png'}
				
var type

signal coin_pickup

func _ready():
	$Tween.interpolate_property($Sprite, 'scale', 
		Vector2(1,1), Vector2(3,3), 0.5, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($Sprite, 'modulate',
		Color(1,1,1,1), Color(1,1,1,0), 0.5, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)

func init(_type, pos):
	type = _type
	$Sprite.texture = load(textures[type])
	position = pos
	
func pickup():
	match type:
		'coin':
			emit_signal('coin_pickup', 1)
			$CoinPickupPlayer.play()
		'key_red', 'key_green':
			$KeyPickupPlayer.play()
	$CollisionShape2D.disabled=true
	$Tween.start()
	

func _on_Tween_tween_completed(object, key):
	queue_free()
