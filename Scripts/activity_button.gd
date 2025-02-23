extends Button

@export var activity_button_icon:Texture2D
@export var activity_draggable:PackedScene

var _is_dragging:bool = false
var _draggable:Node
var _cam:Camera3D
var RAYCAST_LENGTH:float = 500

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	icon = activity_button_icon
	_draggable = activity_draggable.instantiate()
	add_child(_draggable)
	_draggable.visible = false
	_cam = get_viewport().get_camera_3d()

func _physics_process(_delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var space_state = _draggable.get_world_3d().direct_space_state
		var mouse_pos:Vector2 = get_viewport().get_mouse_position()
		var origin:Vector3 = _cam.project_ray_origin(mouse_pos)
		var end:Vector3 = origin + _cam.project_ray_normal(mouse_pos) * RAYCAST_LENGTH
		var query = PhysicsRayQueryParameters3D.create(origin, end)
		query.collide_with_bodies = true
		var rayResult:Dictionary = space_state.intersect_ray(query)
		if rayResult.size() > 0:
			#print(rayResult)
			var co:CollisionObject3D = rayResult.get("collider")
			#if co.get_groups()[0] == "tile_snow":
			_draggable.visible = true
			_draggable.global_position = Vector3(co.global_position.x, 0.2, co.global_position.z)
		else:
			_draggable.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_down() -> void:
	_is_dragging = true
	
	
func _on_button_up() -> void:
	_is_dragging = false
	_draggable.visible = false
