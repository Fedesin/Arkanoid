extends KinematicBody2D
class_name Player

onready var powerup_timer_node : Timer = $powerup_timer
onready var spr_player_node : AnimatedSprite = $spr_player
onready var col_player_node : CollisionShape2D = $col_player
onready var gift_sound_node :AudioStreamPlayer2D = $gift_sound

const Right : int = 1
const Left : int = -1

export var speed : int = 4
""""
esto hace que se ejecute una sola vez cuando se presiona la tecla
func _input(event):
	if event.is_action_pressed("mover_derecha"):
		position.x = position.x + speed
	if event.is_action_pressed("mover_izquierda"):
		position.x = position.x - speed	
"""


# Called when the node enters the scene tree for the first time.
func _ready():
	GLOBALS.connect("gift_picked",self,"_on_gift_gift_picked")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed("mover_derecha"):
		var movement : Vector2 = Vector2(speed,0)
		move_and_collide(movement)
	if Input.is_action_pressed("mover_izquierda"):
		var movement : Vector2 = Vector2(-speed,0)
		move_and_collide(movement)

func enable_powerup() -> void:
	#que empiece el timer
	powerup_timer_node.start()
	#cambiamos el frame del sprite
	spr_player_node.frame = 1
	#cambiamos el tamaño de la colisión
	col_player_node.shape.extents.x = 38
	#emitimos el sonidito
	gift_sound_node.play()

func disable_powerup() -> void:
	spr_player_node.frame = 0
	col_player_node.shape.extents.x = 32

func _on_gift_gift_picked() -> void:
	enable_powerup()


func _on_powerup_timer_timeout():
	disable_powerup()
