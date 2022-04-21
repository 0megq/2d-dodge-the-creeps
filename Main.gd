extends Node

export var mob_scene : PackedScene

var score : int = 0
onready var score_timer : Timer = $ScoreTimer
onready var mob_timer : Timer = $MobTimer
onready var start_timer : Timer = $StartTimer
onready var hud : CanvasLayer = $HUD


func _ready():
	randomize()
	

func new_game():
	score = 0
	hud.update_score(score)
	
	get_tree().call_group("mobs", "queue_free")
	$Player.start($StartPosition.position)
	
	hud.show_message("Get ready...")
	
	start_timer.start()
	$Music.play()
	
	yield(start_timer, "timeout")
	
	score_timer.start()
	mob_timer.start()
	

func game_over():
	score_timer.stop()
	mob_timer.stop()
	hud.show_game_over()
	$Music.stop()
	$GameOver.play()


func _on_MobTimer_timeout():
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.unit_offset = randf()
	
	var mob = mob_scene.instance()
	add_child(mob)
	
	mob.position = mob_spawn_location.position
	
	var direction =  mob_spawn_location.rotation + PI / 2
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	var velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = velocity.rotated(direction)


func _on_ScoreTimer_timeout():
	score += 1
	hud.update_score(score)
