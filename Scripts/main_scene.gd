extends Node

var game_menu_scene = preload("res://Sences/UI/game_menu_screen.tscn")
var game_menu: CanvasLayer


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if game_menu != null and is_instance_valid(game_menu):
			_on_return_to_game()
		else:
			_show_pause_menu()


func _show_pause_menu() -> void:
	game_menu = game_menu_scene.instantiate()
	game_menu.is_pause_mode = true
	game_menu.return_to_game.connect(_on_return_to_game)
	add_child(game_menu)
	get_tree().paused = true


func _on_return_to_game() -> void:
	if game_menu != null and is_instance_valid(game_menu):
		game_menu.queue_free()
		game_menu = null
	get_tree().paused = false
