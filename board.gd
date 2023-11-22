extends Sprite2D

@export var pat : PackedScene
@export var aru : PackedScene

signal game_finished

var nrow = 3
var cell_dim : Vector2

var move : Node2D
var pos : Vector2
var grid
var player : int


func _ready():
	cell_dim = Vector2(texture.get_width() / 3, texture.get_height() / 3)
	restart_game()


func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if get_rect().has_point(to_local(event.position)):
				pos = get_location(event)
				add_move(player, pos)
				if check(grid):
					_on_game_finished()
					get_tree().paused = true
				player *= -1


func get_location(event):
	
		var cell = (to_local(event.position) + cell_dim * 1.5) / cell_dim
		return cell.floor()
		return 


func add_move(player, pos):
	if player == 1:
		move = pat.instantiate()
	else:
		move = aru.instantiate()
	move.position = cell_dim * (pos - Vector2(1, 1))
	add_child(move)
	grid[pos.x][pos.y] = player


func check(grid):
	for i in range(nrow):
		if abs(grid[i][0] + grid[i][1] + grid[i][2]) == 3:
			return 1
		elif abs(grid[0][i] + grid[1][i] + grid[2][i]) == 3:
			return 1
		elif abs(grid[0][0] + grid[1][1] + grid[2][2]) == 3:
			return 1
		elif abs(grid[2][0] + grid[1][1] + grid[0][2]) == 3:
			return 1
	return 0

func restart_game():
	player = -1
	grid = [
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0]
	]
	get_tree().call_group("moves", "queue_free")
	get_tree().paused = false


func _on_game_finished():
	game_finished.emit()
