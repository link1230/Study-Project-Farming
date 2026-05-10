extends CanvasLayer

var is_pause_mode: bool = false

signal return_to_game

const MAIN_SCENE_PATH = "res://Sences/levels/main_scene.tscn"

@onready var start_game_button: Button = $MarginContainer/VBoxContainer/StartGameButton
@onready var save_game_button: Button = $MarginContainer/VBoxContainer/SaveGameButton
@onready var exit_game_button: Button = $MarginContainer/VBoxContainer/ExitGameButton


func _ready() -> void:
	if is_pause_mode:
		start_game_button.text = "返回游戏"
		process_mode = Node.PROCESS_MODE_ALWAYS


func _input(event: InputEvent) -> void:
	if is_pause_mode and event.is_action_pressed("ui_cancel"):
		return_to_game.emit()


func _on_start_game_button_pressed() -> void:
	if is_pause_mode:
		return_to_game.emit()
		return
	get_tree().change_scene_to_file(MAIN_SCENE_PATH)


func _on_save_game_button_pressed() -> void:
	if not is_pause_mode:
		return
	SaveGameManager.save_game()


func _on_exit_game_button_pressed() -> void:
	if is_pause_mode:
		get_tree().paused = false
	get_tree().quit()
