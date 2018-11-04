extends Node2D

export (PackedScene) var Enemy
export (PackedScene) var Pickup

onready var items = $Items

var doors_green = []
var doors_red = []

var doors_by_key = {'key_red': doors_red, 
	'key_green': doors_green}

func _ready():
	randomize()
	$Items.hide()
	set_camera_limits()
	#look up doors
	find_doors('door_red',doors_red)
	find_doors('door_green',doors_green)
	#var door_red_id = $Walls.tile_set.find_tile_by_name('door_red')
	#for cell in $Walls.get_used_cells_by_id(door_red_id):
	#	doors.append(cell)
	spawn_items()
	$Player.connect('dead',self,'game_over')
	$Player.connect('grabbed_key', self, '_on_Player_grabbed_key')
	$Player.connect('win', self, '_on_Player_win')
	
func find_doors(type, container):
	var door_id = $Walls.tile_set.find_tile_by_name(type)
	for cell in $Walls.get_used_cells_by_id(door_id):
		container.append(cell)
	
func set_camera_limits():
	var map_size = $Ground.get_used_rect()
	var cell_size = $Ground.cell_size
	$Player/Camera2D.limit_left = map_size.position.x * cell_size.x
	$Player/Camera2D.limit_top = map_size.position.y * cell_size.y
	$Player/Camera2D.limit_right = map_size.end.x * cell_size.x
	$Player/Camera2D.limit_bottom = map_size.end.y * cell_size.y
	
func spawn_items():
	for cell in items.get_used_cells():
		var id = items.get_cellv(cell)
		var type = items.tile_set.tile_get_name(id)
		var pos = items.map_to_world(cell)+items.cell_size/2
		match type:
			'slime_spawn':
				var s = Enemy.instance()
				s.position = pos
				s.tile_size = items.cell_size
				add_child(s)
			'player_spawn':
				$Player.position = pos
				$Player.tile_size = items.cell_size
			'coin', 'key_red', 'key_green', 'star':
				var p = Pickup.instance()
				p.init(type,pos)
				add_child(p)
				p.connect('coin_pickup', $HUD, 'update_score')
			
func game_over():
	Global.game_over()
 
func _on_Player_win():
	Global.next_level()
	
func _on_Player_grabbed_key(type):
	var doors = doors_by_key[type]
	for cell in doors:
		$Walls.set_cellv(cell,-1)	
		
		
		
		
		
		
		