extends Sprite

var speed = 40  
var jump_duration = 1.5 
var original_y: float  
var timer: float = 0.0  
var jumping = true

func _ready():
	original_y = position.y

func _process(delta):
	timer += delta
	
	if timer >= jump_duration:
		position.y += speed * delta
		jumping = false
		timer = 0.0
	else:
		var jump_direction = Vector2(0, 1) if timer < jump_duration / 2 else Vector2(0, -1)
		position += jump_direction * speed * delta
		
		if abs(position.y - original_y) <= 1.0:  # Um pequeno limite para garantir
			jumping = true
