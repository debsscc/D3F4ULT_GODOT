extends KinematicBody2D

onready var _animated_sprite = $"AnimatedSprite"

const walk_speed = -250
var portal_global_position = Vector2(50, 50)
var screen_size
var dialog_active = false  # Adicione esta variável para controlar o estado do diálogo

func _ready():
	screen_size = get_viewport_rect().size
	print(screen_size.x)

func _physics_process(delta):
	if dialog_active:
		return  # Impede o movimento do jogador enquanto o diálogo estiver ativo

	var velocity = Vector2(0, 0)

	if Input.is_action_pressed("move_left"):
		velocity.x = -walk_speed
		_animated_sprite.play("walk_l")
	elif Input.is_action_pressed("move_right"):
		velocity.x = walk_speed
		_animated_sprite.play("walk_r")
	else:
		_animated_sprite.play("frente")
	
	move_and_collide(velocity * delta)
	
	position.x = clamp(position.x, 0, screen_size.x - 40)

func _on_dialog_finished():
	get_tree().paused = false
	dialog_active = false
