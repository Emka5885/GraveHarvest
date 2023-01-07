extends KinematicBody2D
class_name Player

const PlayerHurtSound = preload("res://Player/PlayerHurtSound.tscn")

export var ACCELERATION = 500
export var speed = 80
var speed_on_path = 35 # speed without baggage
export var FRICTION = 500

enum {
	MOVE,
	ATTACK
}

var state = MOVE
var velocity = Vector2.ZERO
var roll_vector = Vector2.DOWN

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitbox = $HitboxPivot/SwordHitbox
onready var hurtbox = $Hurtbox
onready var blinkAnimationPlayer = $BlinkAnimationPlayer

func _ready():
	randomize()
	animationTree.active = true
	swordHitbox.knockback_vector = roll_vector
# warning-ignore:return_value_discarded
	PlayerStats.connect("fertilizer_changed", self, "set_fertilizer")

func _physics_process(delta):
	print(speed)
	match state:
		MOVE:
			move_state(delta)
		
		ATTACK:
			attack_state()
	
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		swordHitbox.knockback_vector = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * speed, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move()
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK

func attack_state():
	velocity = Vector2.ZERO
	animationState.travel("Attack")

func move():
	velocity = move_and_slide(velocity)

func attack_animation_finished():
	state = MOVE

func _on_Hurtbox_area_entered(area):
	PlayerStats.fertilizer -= 1
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var my_random_number = rng.randf_range(-250, 250)
	var my_random_number2 = rng.randf_range(-250, 250)
	while (my_random_number < 100 and my_random_number > -100) or (my_random_number2 < 100 and my_random_number2 > -100):
		my_random_number = rng.randf_range(-250, 250)
		my_random_number2 = rng.randf_range(-250, 250)
	var knockback_X = my_random_number
	var knockback_Y = my_random_number2
	
	if area.position.x >= position.x:
		knockback_X *= -1
	if area.position.y >= position.y:
		knockback_Y *= -1
		
	velocity.x += knockback_X
	velocity.y += knockback_Y
	hurtbox.start_invincibility(0.6)
	hurtbox.create_hit_effect()
	var playerHurtSound = PlayerHurtSound.instance()
	get_tree().current_scene.add_child(playerHurtSound)
	
func _on_Hurtbox_invincibility_started():
	blinkAnimationPlayer.play("Start")

func _on_Hurtbox_invincibility_ended():
	blinkAnimationPlayer.play("Stop")

func set_fertilizer(value):
	if value == 0:
		speed = 105
	else:
		speed = 80

func _on_PathChecker_body_entered(_body):
	speed += speed_on_path

func _on_PathChecker_body_exited(_body):
	speed -= speed_on_path
