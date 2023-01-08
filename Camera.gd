extends Camera2D

var shake_amount = 0
var default_offset = offset

func _ready():
	randomize()

func _physics_process(delta):
	offset = Vector2(rand_range(-shake_amount, shake_amount), rand_range(-shake_amount, shake_amount)) * delta + default_offset

func shake(new_shake=40, shake_time=0.7):
	shake_amount += new_shake
	yield(get_tree().create_timer(shake_time), "timeout")
	shake_amount = 0
