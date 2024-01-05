class_name Conductor extends AudioStreamPlayer


var bpm = 139;

var song_position = 0.0;
var song_position_in_beats = 1;
var time_sig = 4;
var crotchet = 60.0 / bpm;
var last_beat = 0.0;
var current_measure = 1

var audio_stream_ref = null;

signal beat(position)

# Called when the node enters the scene tree for the first time.
func _ready():
	crotchet = 60.0 / bpm;
	audio_stream_ref = self as AudioStreamPlayer

	pass


func _physics_process(_delta):
	if(audio_stream_ref.playing):
		# print_debug("Conductor: " + str(song_position_in_beats));
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