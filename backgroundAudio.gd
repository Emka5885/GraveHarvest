extends AudioStreamPlayer

var audio_file

func _ready():
	var x = int(rand_range(1,5))
	audio_file = ("res://Audio/0"+str(x)+" - DavidKBD - Belmont Chronicles Pack.ogg")
	self.stream = load(audio_file)
	self.play()
