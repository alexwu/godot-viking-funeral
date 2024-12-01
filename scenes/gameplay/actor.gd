extends CharacterBody2D

@export var dialogue_name: String = name
@export var texture: Texture2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("idle")
	if texture:
		sprite_2d.texture = texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta

	move_and_slide()
