extends Camera3D

@export var move_speed: float = 10.0
@export var zoom_speed: float = 2.0
@export var rotation_speed: float = 1.0

var zoom_min: float = 5.0
var zoom_max: float = 50.0

func _process(delta):
	# Move camera using WASD keys
	var move_dir = Vector3.ZERO
	if Input.is_action_pressed("ui_right"):  # D key
		move_dir.x += 1
	if Input.is_action_pressed("ui_left"):   # A key
		move_dir.x -= 1
	if Input.is_action_pressed("ui_down"):   # S key
		move_dir.z += 1
	if Input.is_action_pressed("ui_up"):     # W key
		move_dir.z -= 1
	
	translate(move_dir * move_speed * delta)

	# Zoom using scroll wheel
	var scroll = Input.get_axis("zoom_in", "zoom_out")  # Map "zoom_in" to Mouse Wheel Up, "zoom_out" to Mouse Wheel Down
	if scroll:
		position.y = clamp(position.y - scroll * zoom_speed, zoom_min, zoom_max)

	# Rotate with right mouse button
	if Input.is_action_pressed("rotate_camera"):
		var mouse_delta = Input.get_last_mouse_velocity()
		rotate_y(-mouse_delta.x * rotation_speed * delta)
