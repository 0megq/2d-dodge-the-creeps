extends RigidBody2D

export var min_speed: float = 150
export var max_speed: float = 250

onready var anim_sprite = $AnimatedSprite

func _ready():
	anim_sprite.playing = true
	var mob_types = anim_sprite.frames.get_animation_names()
	anim_sprite.animation = mob_types[randi() % mob_types.size()]


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
