extends KinematicBody2D

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

var start_position
onready var positionTimer = $PositionTimer

export var ACCELERATION = 300
export var MAX_SPEED = 40
export var FRICTION = 200
export var WANDER_TARGET_RANGE = 4

enum {
	IDLE,
	WANDER,
	CHASE
}

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

var state = CHASE

onready var sprite = $AnimatedSprite
onready var playerDetectionZone = $PlayerDetectionZone
onready var hurtbox = $Hurtbox
onready var softCollision = $SoftCollision
onready var wanderController = $WanderController
onready var animationPlayer = $AnimationPlayer
onready var label = $Label
onready var textAnimation = $TextAnimation

var health = 3

var dialogue = ["better call the ghost-catchers", "You really think that you can win?", "It will never end...", "Remember to clean our houses...", "i know what you have done", "Do you really think you can get away with it?", "can you remind me how ice creams taste?", "I haven't felt alive in years!", "Whats the diffrence between pessimist and optimist? - Pessimist see here only the crosses. Optimist sees the pluses", "NOW you are going back there!", "Taking take care of the pumpkin? What about me?", "Soon you will be in this grave", "Did you forget about something?", "pumpkin? i am going to pump you  there where you belong!", "Your pumpkin isn't safe...."]
var dialogue_index = 0

signal respawn_ghost

func _ready():
	positionTimer.start()
	state = pick_random_state([IDLE, WANDER])

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			hide_text()
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
				
		WANDER:
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
			accelerate_towards_point(wanderController.target_position, delta)
			if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGE:
				update_wander()
			
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				show_text()
				accelerate_towards_point(player.global_position, delta)
			else:
				state = IDLE

	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 400
	velocity = move_and_slide(velocity)

func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = velocity.x < 0

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE

func update_wander():
	state = pick_random_state([IDLE, WANDER])
	wanderController.start_wander_timer(rand_range(1, 3))

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func show_text():
	if !label.visible:
		randomize()
		dialogue_index = rand_range(0, dialogue.size()-1)
		label.text = dialogue[dialogue_index]
		label.visible = true
		textAnimation.play("FadeIn")

func hide_text():
	if label.visible:
		textAnimation.play("FadeOut")

func _on_Hurtbox_area_entered(area):
	health -= 1
	knockback = area.knockback_vector * 150
	if health == 0:
		animationPlayer.play("Dead")
		hurtbox.queue_free()
		$Hitbox.queue_free()
	else:
		hurtbox.create_hit_effect()
		hurtbox.start_invincibility(0.4)

func on_Animation_Dead_Finished():
	connect("respawn_ghost", get_parent(), "_on_Ghost_respawn")
	emit_signal("respawn_ghost", start_position)
	queue_free()

func _on_Hurtbox_invincibility_started():
	animationPlayer.play("Start")

func _on_Hurtbox_invincibility_ended():
	animationPlayer.play("Stop")

func _on_PositionTimer_timeout():
	start_position = position
	positionTimer.queue_free()
