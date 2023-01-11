extends AudioStreamPlayer

var last_pitch = 1.0

export var bottom_range = 0.4
export var top_range = 1.0

func play(from_position=0.0):
	
	randomize()
	
	pitch_scale = rand_range(bottom_range, top_range)
	
	while abs(pitch_scale - last_pitch) < 0.1:
		randomize()
		pitch_scale = rand_range(bottom_range, top_range)
	
	last_pitch = pitch_scale
	
	.play(from_position)

