extends Panel

@onready var animated_sprite_2d: AnimatedSprite2D = $Emote/AnimatedSprite2D
@onready var emote_idle_timer: Timer = $EmoteIdleTimer

var idle_emotes: Array = ["Emote_1_Idle","Emote_2_Slime","Emote_3_Ear_Wave","Emote_4_Blink"]

func _ready() -> void:
	animated_sprite_2d.play("Emote_1_Idle")
	
func play_emote(animation:String) -> void:
	animated_sprite_2d.play(animation)

func _on_emote_idle_timer_timeout() -> void:
	var index = randi_range(0,3)
	var emote = idle_emotes[index]
	
	animated_sprite_2d.play(emote)
