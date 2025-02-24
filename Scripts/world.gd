extends Node3D

@onready var enemy : PackedScene = preload("res://Mobs/ufo.tscn")
@onready var cam = $camera_base/camera_socket/Camera3D

var enemies_to_spawn : int = 3
var can_spawn : bool = true
var RAYCAST_LENGTH:float = 500

@export var cash = 100
@export var life = 3

func _ready():
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		enemy.enemy_destroyed.connect(add_money)
		enemy.player_damage.connect(damage_player)

		
func add_money(amount: int):
	cash += amount
	
func damage_player(amount: int):
	life -= amount
	if life <= 0:
		#self.queue_free()
		get_node("GameOver").game_over()



func _process(delta):
	$Control2/CashLabel.text = "Gold: %d" % cash
	$Control3/LifeLabel.text = "Lives: %d" % life
	game_manager()
	
func game_manager() -> void:
	if enemies_to_spawn > 0 and can_spawn:
		$SpawnTimer.start()
		
		var tempEnemy = enemy.instantiate()
		var enemy_script_node = tempEnemy.get_node("Enemy")
		
		if enemy_script_node:
			enemy_script_node.enemy_destroyed.connect(add_money)
			enemy_script_node.player_damage.connect(damage_player)

		
		$Path.add_child(tempEnemy)
		
		enemies_to_spawn -= 1
		
		can_spawn = false
		
	#if enemies_to_spawn <= 0 and !can_spawn:
		#get_node("WinScreen").game_win()

func _on_spawn_timer_timeout() -> void:
	can_spawn = true
