extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$RestartButton.hide()
	$RestartLabel.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_board_game_finished():
	$RestartButton.show()
	$RestartLabel.show()


func _on_button_pressed():
	$RestartButton.hide()
	$RestartLabel.hide()
	$board.restart_game()
