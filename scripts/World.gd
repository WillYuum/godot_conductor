extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	enable_movement_on_character();
	pass;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


const CHARACTER_MOVEMENT_SCRIPT = "res://scripts/character_movement.gd";


func enable_movement_on_character():
	print_debug("Enabling movement on character");

	var loaded_script = load(CHARACTER_MOVEMENT_SCRIPT);
	var green_character = get_node("GreenCharacter");

	var node_with_script = Node.new();
	node_with_script.set_script(loaded_script);
	green_character.add_child(node_with_script);



	# delay_callback(2.0, func():
	# 	print_debug("Disabling movement on character");
	# 	node_with_script.set_process(false);
	# 	pass;
	# );
	
	pass;


func delay_callback(delayInSeconds, callback: Callable):
	await get_tree().create_timer(delayInSeconds).timeout;
	callback.call();