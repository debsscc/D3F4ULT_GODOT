extends Control

export var dialogPath: String = ""
export (float) var textSpeed: float = 0.05

var dialog: Array
var phraseNum: int = 0

onready var dialogText: RichTextLabel = $Text

func _ready():
	dialogText.visible_characters = 0  # Define a visibilidade inicial para 0
	$Timer.wait_time = textSpeed  # Configura o tempo de espera do Timer com base na variável textSpeed
	dialog = getDialog()
	assert(dialog, "Dialog not found")

	showNextPhrase()

func _on_Enviar_pressed():
	if phraseNum < len(dialog):
		showNextPhrase()

func getDialog() -> Array:
	var f = File.new()
	assert(f.file_exists(dialogPath), "File path does not exist")

	f.open(dialogPath, File.READ)
	var json = f.get_as_text()

	var output = parse_json(json)

	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []

func showNextPhrase() -> void:
	if phraseNum >= len(dialog):
		emit_signal("last_line_reached")  # Sinaliza que a última linha foi alcançada
		return

	$Text.bbcode_text = dialog[phraseNum]["Text"]

	$Text.visible_characters = 0

	while $Text.visible_characters < len($Text.text):
		$Text.visible_characters += 1

		$Timer.start()
		yield($Timer, "timeout")

	phraseNum += 1
	return

func _on_Timer_timeout():
	if dialogText.visible_characters < len(dialogText.bbcode_text):
		dialogText.visible_characters += 1
	else:
		emit_signal("dialogue_finished")  # Emita o sinal quando a frase é concluída
		$Timer.stop()

signal last_line_reached
