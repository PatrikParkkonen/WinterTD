extends CharacterBody3D

signal enemy_destroyed(value)
signal player_damage(value)

@export var speed : int = 2
@export var health : int = 15
@export var max_health : int = 15
@export var destroy_value : int = 25
@export var damage_value : int = 1


@onready var Path : PathFollow3D = get_parent()
@onready var health_bar := $SubViewport/ProgressBar

func _ready():
	# Initialize health bar
	health_bar.value = health
	health_bar.max_value = max_health

func _physics_process(delta):
	Path.set_progress(Path.get_progress() + speed * delta)
	
	if Path.get_progress_ratio() >= 0.99:
		player_damage.emit(damage_value)
		Path.queue_free()



func take_damage(damage : int) -> void:
	health -= damage
	health_bar.value = health  # Update the health bar
	
	if health <= 0:
		enemy_destroyed.emit(destroy_value)
		queue_free()
