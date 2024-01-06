class_name Level_one_controller extends Node2D

# Array to hold Node2D objects to be scaled on beat
@export var scaledOnBeatObjects : Array[Node2D] = []

# Tween for smooth scaling animation
# var tween : Tween;

# Called when the node enters the scene tree for the first time.
func _ready():
	# tween = create_tween();
	# var _conductor = get_node("/root/Conductor") as Conductor;
	# _conductor.beat.connect(effect_on_beat);

	# Add the tween to the node
	# Node.new().add_child(tween);
	pass;


var _conductor: Conductor;

func setup_level(conductor: Conductor):
	conductor.beat.connect(effect_on_beat);
	_conductor = conductor;


var tween: Tween;

# Function to apply effects on beat
func effect_on_beat(song_position):
	print_debug("Beat!", song_position);
	if tween:
		tween.kill();
	# tween.free();
	
	tween = create_tween();
	var beatDuration = _conductor.get_crotchet() - 0.05;

	for obj in scaledOnBeatObjects:
		var originaScale = obj.scale;
		
	
		# var tween = create_tween();

		# var tweenDuration = beatDuration;

		# print_debug("tweenDuration", tweenDuration);

		
		obj.scale = obj.scale * 1.2;
		tween.tween_property(obj, "scale", originaScale, beatDuration).set_delay(0.0);
		tween.set_parallel(true);
		# tween.play();

