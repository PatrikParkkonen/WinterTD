extends Node3D

# camera_move
@export_range(0,100,1) var camera_move_speed:float = 20.0

# camera_zoom
var camera_zoom_direction:float = 0
@export_range(0,100,1) var camera_zoom_speed = 40.0
@export_range(0,100,1) var camera_zoom_min = 2.0
@export_range(0,100,1) var camera_zoom_max = 10.0
@export_range(0,2,0.1) var camera_zoom_speed_damp:float = 0.92

# Flags
var camera_can_process:bool = true
var camera_can_move_base:bool = true
var camera_can_zoom:bool = true

# Nodes
@onready var camera_socket:Node3D = $camera_socket
@onready var camera:Camera3D = $camera_socket/Camera3D



func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	if !camera_can_process:return
	camera_base_move(delta)
	camera_zoom_update(delta)
	
func _unhandled_input(event: InputEvent) -> void:
	# Camera Zoom
	if event.is_action("camera_zoom_in"):
		camera_zoom_direction = -1
	elif event.is_action("camera_zoom_out"):
		camera_zoom_direction = 1
	

# Moves the base of the camera using WASD
func camera_base_move(delta:float) -> void:
	if !camera_can_move_base:return
	var velocity_direction:Vector3 = Vector3.ZERO
	
	if Input.is_action_pressed("camera_forward"): velocity_direction -= transform.basis.z
	if Input.is_action_pressed("camera_backward"): velocity_direction += transform.basis.z
	if Input.is_action_pressed("camera_right"): velocity_direction += transform.basis.x
	if Input.is_action_pressed("camera_left"): velocity_direction -= transform.basis.x

	position += velocity_direction.normalized() * camera_move_speed * delta

# Controls the camera zoom	
func camera_zoom_update(delta:float) -> void:
	if !camera_can_zoom:return
	
	var new_zoom:float = clamp(camera.position.z + camera_zoom_speed * camera_zoom_direction * delta, camera_zoom_min, camera_zoom_max)
	camera.position.z = new_zoom
	camera_zoom_direction *= camera_zoom_speed_damp
