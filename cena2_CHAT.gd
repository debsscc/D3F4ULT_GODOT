extends Control

onready var time = get_node("VBoxContainer/time_label")
onready var defaultDialogControl = $Default_chat
onready var secondDialogControl = $Mike_chat
onready var EnviarButton = $Enviar
onready var Video = $VideoPlayer  # Referência ao nó de vídeo 
onready var pause = $Popup_Menu
var isVideoPlaying = false

func _ready():
	defaultDialogControl.connect("dialogue_finished", self, "_on_dialogue_finished")
	secondDialogControl.connect("dialogue_finished", self, "_on_dialogue_finished")
	defaultDialogControl.connect("last_line_reached", self, "_on_last_line_reached")
	secondDialogControl.connect("last_line_reached", self, "_on_last_line_reached")

	pause.hide()
	$Cutscene_Escola.hide()
	
func _on_dialogue_finished():
	defaultDialogControl.EnviarButton.disabled = false
	secondDialogControl.EnviarButton.disabled = false
	
func _on_last_line_reached():
	VideoPlayer.start()

func _process(_delta):
	var datetime = Time.get_time_dict_from_system()

	var meridiem = "AM"
	var hour = datetime["hour"]

	if hour > 12:
		meridiem = " PM"
		hour -= 12

	var minute = "%02d" % datetime["minute"]

	var time_str = str(hour) + ":" + str(minute) + meridiem
	time.text = time_str

	_abrir_pause()
func _abrir_pause():
	if Input.is_action_pressed("ui_cancel"):  # Verifica a tecla "Esc"
		$Popup_Menu.show()


func _on_sair_do_chat_pressed():
	$Cutscene_Escola.show()
	$Cutscene_Escola.play()

func _on_Menu_pressed():
	$Popup_Menu.hide()

func _on_Menu2_pressed():
	get_tree().change_scene("res://Menu.tscn")

func _on_Cutscene_Escola_finished():
	get_tree().change_scene("res://Cena3.tscn")
