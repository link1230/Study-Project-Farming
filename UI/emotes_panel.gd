extends Panel

@onready var animated_sprite_2d: AnimatedSprite2D = $Emote/AnimatedSprite2D
@onready var emote_idle_timer: Timer = $EmoteIdleTimer

var idle_emotes: Array = ["Emote_1_Idle","Emote_2_Slime","Emote_3_Ear_Wave","Emote_4_Blink"]

func _ready() -> void:
	animated_sprite_2d.play("Emote_1_Idle")
	
	InventoryManagement.inventory_changed.connect(on_inventory_changed)
	GameDialogueManager.feed_the_animals.connect(on_feed_the_animals)
	
func play_emote(animation:String) -> void:
	animated_sprite_2d.play(animation)

func _on_emote_idle_timer_timeout() -> void:
	var index = randi_range(0,3)
	var emote = idle_emotes[index]
	
	animated_sprite_2d.play(emote)

func on_inventory_changed() -> void:
	animated_sprite_2d.play("Emote_6_Excited")
	
func on_feed_the_animals() -> void:
	animated_sprite_2d.play("Emote_5_Love_Kiss")
