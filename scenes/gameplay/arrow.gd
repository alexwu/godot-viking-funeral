extends RigidBody2D

@onready var hit_box: Area2D = $HitBox


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Arrow spawned")


func _physics_process(_delta):
	# Update the arrow's rotation based on its velocity
	if !is_freeze_enabled() && linear_velocity.length() > 0:
		rotation = linear_velocity.angle()


func _integrate_forces(_state):
	pass


func _on_body_entered(body: Node) -> void:
	on_hit(body)


func on_hit(_body: Node) -> void:
	# print("Arrow on_hit: " + body.name)
	# if body.has_method("on_hit"):
	# 	body.on_hit()
	if !is_freeze_enabled():
		call_deferred("set_freeze_enabled", true)


func _on_hit_box_body_entered(body: Node2D) -> void:
	on_hit(body)
