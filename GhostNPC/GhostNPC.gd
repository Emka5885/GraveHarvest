extends KinematicBody2D

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
export var WANDER_TARGET_RANGE = 5

enum {
	IDLE,
	WANDER
}

var velocity = Vector2.ZERO
var state = IDLE
var audio_nr = 1
var dialogue_index = 0
var dialogue = ["This place is cursed! Especially for poor pumpkins...", "looong time ago, terrible things happened in this place", "a lot of people died in the name of the pumpkins", "This is exactly where the Pumpkin Festival took place. Every year people from each corner of the world came here to celebrate", "During the last celebration, everything went wrong", "The man who hated  pumpkins the most, slaughtered all the festival participants with cold blood", "No matter that they were children or elderly people", "After everything, he became the thing he hated the most...", "Love kills... especially the one with pumpkins."
]

onready var sprite = $Sprite
onready var label = $Label
onready var animationPlayer = $AnimationPlayer
onready var wanderController = $WanderController
onready var playerDetectionZone = $PlayerDetectionZone
onready var audioStream = $AudioStreamPlayer

func _on_PlayerDetectionZone_body_entered(body):
	if body is Player:
		label.text = dialogue[dialogue_index]
		dialogue_index += 1
		if dialogue_index > dialogue.size()-1:
			dialogue_index = 0
		audioStream.stream = load("res://GhostNPC/ghost_cry"+str(audio_nr)+".wav")
		audio_nr += 1
		if audio_nr > 3:
			audio_nr=1
		audioStream.play()
		animationPlayer.play("FadeIn")

func _on_PlayerDetectionZone_body_exited(body):
	if body is Player:
		animationPlayer.play("FadeOut")
		yield(get_tree().create_timer(1), "timeout")

func _physics_process(delta):	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			if wanderController.get_time_left() == 0:
				update_wander()
		WANDER:
			if wanderController.get_time_left() == 0:
				update_wander()
			accelerate_towards_point(wanderController.target_position, delta)
			if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGE:
				update_wander()
	
	if playerDetectionZone.can_see_player():
		state = IDLE
	velocity = move_and_slide(velocity)

func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = velocity.x < 0

func update_wander():
	state = pick_random_state([IDLE, WANDER])
	wanderController.start_wander_timer(rand_range(0.5, 0.7))

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()
