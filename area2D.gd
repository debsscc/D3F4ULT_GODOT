extends Area2D

var active = false

func _ready():
	connect("body_entered", self, '_on_NPC_body_entered')
	connect("body_exited", self, '_on_NPC_body_exited')

func _input(event):
	if get_node_or_null('DialogNode') == null:
		if event.is_action_pressed("mouse_pressed") and active:
			get_tree().paused = true
			var dialog = Dialogic.start('sala_cena4')
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect('timeline_finished', self, 'unpause') # Use 'timeline_finished' em vez de 'sala_cena4'
			add_child(dialog)

func unpause(timeline_name):
	get_tree().paused = false 

func _on_NPC_body_entered(body):
	if body.name == 'KinematicBody2D':
		active = true

func _on_NPC_body_exited(body):
	if body.name == 'KinematicBody2D':
		active = false
