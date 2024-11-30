extends CharacterBody2D

@export var dialogue_name: String = name
@export var texture: Texture2D

@onready var sprite_2d: Sprite2D = $Sprite2D

var _gravity = 4500

# Called when the node enters the scene tree for the first time.
# func _ready() -> void:
#	if texture:
#		sprite_2d.texture = texture

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	velocity.y += _gravity * delta
		
	print(velocity)
	
	move_and_slide()
