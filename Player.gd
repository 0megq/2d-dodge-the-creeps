extends Area2D

signal hit

export var speed: float = 400

onready var screen_size: Vector2 = get_viewport_rect().size
onready var  anim_sprite: AnimatedSprite = $AnimatedSprite
onready var col_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	hide()


func _process(delta : float) -> void:
	var direction =  Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x += -1

	if Input.is_action_pressed("move_up"):
		direction.y += -1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
		
	if direction.length() > 0:
		direction = direction.normalized()
		anim_sprite.play()
	else:
		anim_sprite.stop()
	
	position += direction * speed * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if direction.x != 0:
		anim_sprite.animation = "right"
		anim_sprite.flip_v = false
		anim_sprite.flip_h = direction.x < 0
	elif direction.y != 0:
		anim_sprite.animation = "up"
		anim_sprite.flip_h = false
		anim_sprite.flip_v = direction.y > 0
		

func start(new_position):
	position = new_position
	show()
	col_shape.disabled = false
	
	
func _on_Player_body_entered(_body):
	hide()
	col_shape.set_deferred("disabled", true)
	emit_signal("hit")
