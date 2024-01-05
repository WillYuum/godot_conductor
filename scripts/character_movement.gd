class_name CharacterMovement extends Node


@onready var speed = 100;

@onready var gameObject: Node2D = get_parent();

@onready var move_dir = Vector2.ZERO;



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_handleMoveCharacter(delta);
	pass

func _input(event):
	_handlePlayerInput(event);
	pass;


func _handleMoveCharacter(delta):
	gameObject.position += move_dir * speed * delta;
	
	pass;


func _handlePlayerInput(event: InputEvent):
	if event is InputEventKey:
		if event.pressed:
			if event.keycode == KEY_A:
				move_dir.x = -1;
			elif event.keycode == KEY_D:
				move_dir.x = 1;
		else:
			move_dir.x = 0;
	pass;

