class_name Conductor extends AudioStreamPlayer


var bpm = 139;

var song_position = 0.0;
var song_position_in_beats = 1;
var time_sig = 4;
var crotchet: float = 0.0;
var last_beat = 0.0;
var current_measure = 1

var audio_stream_ref = null;

signal beat(position)

# Label node for displaying debug information
var debugLabel : Label

# Called when the node enters the scene tree for the first time.
func _ready():
	crotchet = 60.0 / bpm;
	audio_stream_ref = self as AudioStreamPlayer


	debugLabel = Label.new();
	# Node2D.ne .add_child(debugLabel);
	var debugNode = Node2D.new();
	debugNode.name = "DebugNode";
	debugNode.add_child(debugLabel);
	# get_tree().get_root().add_child(debugNode);
	add_child(debugNode);


	pass

func get_crotchet():
	return 60.0 / bpm;

func toggle_music():
	if(audio_stream_ref.playing):
		audio_stream_ref.stop();
	else:
		audio_stream_ref.play();

		# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Update and display debug information
	update_and_display_debug_info();

	# position debug node on bottom left corner of screen
	var left_side_of_screen = get_viewport().get_visible_rect().position.x - get_viewport().get_visible_rect().size.x * 0.475;
	var bottom_of_screen = get_viewport().get_visible_rect().position.y + get_viewport().get_visible_rect().size.y * 0.24;

	debugLabel.position = Vector2(left_side_of_screen, bottom_of_screen);


	# Function to update and display debug information
func update_and_display_debug_info():
    # Create an instance of DebugInfo
	var debug_info = create_debug_info();

    # Build a string with debug information
	var debug_string = "SongPosition: " + str(debug_info.SongPosition) + "\n"
	debug_string += "SongPositionInBeats: " + str(debug_info.SongPositionInBeats) + "\n"
	debug_string += "TimeSignature: " + str(debug_info.TimeSignature) + "\n"
	debug_string += "Crotchet: " + str(debug_info.Crotchet) + "\n"
	debug_string += "LastBeat: " + str(debug_info.LastBeat) + "\n"
	debug_string += "CurrentMeasure: " + str(debug_info.CurrentMeasure)
	# Set the debug string to the Label text
	debugLabel.text = debug_string

# Function to create an instance of DebugInfo
func create_debug_info() -> DebugInfo:
	var debug_info : DebugInfo = DebugInfo.new()
	debug_info.SongPosition = song_position
	debug_info.SongPositionInBeats = song_position_in_beats
	debug_info.TimeSignature = time_sig
	debug_info.Crotchet = crotchet
	debug_info.LastBeat = last_beat
	debug_info.CurrentMeasure = current_measure
	return debug_info

func _physics_process(_delta):
	if(audio_stream_ref.playing):
		song_position = audio_stream_ref.get_playback_position(); + AudioServer.get_time_since_last_mix();
		song_position -= AudioServer.get_output_latency();
		song_position_in_beats = int(floor(song_position / crotchet));
		report_beat();


func report_beat():
	if last_beat < song_position_in_beats:
		if(current_measure > time_sig):
			current_measure = 1;
		print("We have a beat at: " + str(song_position_in_beats) + " in measure: " + str(current_measure));
		emit_signal("beat", song_position_in_beats);

		last_beat = song_position_in_beats;
		current_measure += 1;




class DebugInfo:
	var SongPosition : float = 0.0
	var SongPositionInBeats : int = 1
	var TimeSignature : int = 4
	var Crotchet : float = 0.0
	var LastBeat : float = 0.0
	var CurrentMeasure : int = 1