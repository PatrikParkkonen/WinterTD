extends Node3D

@onready var enemy : PackedScene = preload("res://Mobs/ufo.tscn")
@onready var cam = $camera_base/camera_socket/Camera3D

var enemies_to_spawn : int = 3
var can_spawn : bool = true
var RAYCAST_LENGTH:float = 500



#func _physics_process(_delta):
	#if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		#var space_state = get_world_3d().direct_space_state
		#var mouse_pos:Vector2 = get_viewport().get_mouse_position()
		#var origin:Vector3 = cam.project_ray_origin(mouse_pos)
		#var end:Vector3 = origin + cam.project_ray_normal(mouse_pos) * RAYCAST_LENGTH
		#var query = PhysicsRayQueryParameters3D.create(origin, end)
		#query.collide_with_bodies = true
		#query.exclude = [$Cannon]
		#var rayResult:Dictionary = space_state.intersect_ray(query)
		#if rayResult.size() > 0:
			##print(rayResult)
			#var co:CollisionObject3D = rayResult.get("collider")
			#print(co.get_groups())


func _process(delta):
	game_manager()
	
func game_manager() -> void:
	if enemies_to_spawn > 0 and can_spawn:
		$SpawnTimer.start()
		
		var tempEnemy = enemy.instantiate()
		$Path.add_child(tempEnemy)
		
		enemies_to_spawn -= 1
		
		can_spawn = false

func _on_spawn_timer_timeout() -> void:
	can_spawn = true
