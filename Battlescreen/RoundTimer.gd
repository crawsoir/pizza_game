extends TextureProgressBar
signal roundTimerOver

@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	value = max_value


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (value <= 0):
		emit_signal("roundTimerOver")
	value = (timer.time_left/timer.wait_time)*max_value

func start():
	value = max_value
	timer.start()

func stop():
	timer.stop()
