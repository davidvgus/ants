#uses godot 4.2.2 
class_name Ant extends CharacterBody2D

@onready var sprite := $Sprite2D
@export var factor: float = 0.5
@onready var ant := $"."
@onready var path := []
@onready var nav_point := preload ("res://Scenes/nav_point.tscn")
@onready var nozzle = $Nozzle

var current_food_target = null

func _physics_process(delta: float) -> void:
    move_and_slide()
    if velocity.length() > 0:
        sprite.rotation = velocity.angle()

func darken_sprite(factor: float=1) -> void:
    if sprite:
        sprite.modulate = sprite.modulate * Color(factor, factor, factor)

func lighten_sprite(factor: float=255.0) -> void:
    if sprite:
        sprite.modulate = Color(factor, factor, factor)

func turn_red():
    if sprite:
        sprite.modulate = Color(255, 0, 0)

func turn_green():
    if sprite:
        sprite.modulate = Color(0, 1, 0)

func drop_nav_point():
    var new_nav_point = nav_point.instantiate()
    new_nav_point.global_position = nozzle.global_position
    new_nav_point.owner_ant = self
    #new_nav_point.connect("ant_entered", Callable(self, "_on_nav_point_entered"))
    get_parent().add_child(new_nav_point)
