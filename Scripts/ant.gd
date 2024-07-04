#uses godot 4.2.2 
class_name Ant extends CharacterBody2D

@onready var sprite := $Sprite2D
@export var factor: float = 0.5
@onready var ant := $"."

func _physics_process(delta: float) -> void:
    move_and_slide()
    if velocity.length() > 0:
        sprite.rotation = velocity.angle()

func darken_sprite(factor: float) -> void:
    if sprite:
        sprite.modulate = sprite.modulate * Color(factor, factor, factor)

func lighten_sprite() -> void:
    var sprite_node = ant.get_node("Sprite2D")
    if sprite_node:
        sprite.modulate = Color(254.1, 254.1, 254.1)

func turn_red():
    if sprite:
        sprite.modulate = Color(255, 0, 0)

func turn_green():
    if sprite:
        sprite.modulate = Color(0, 1, 0)
