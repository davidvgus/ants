#uses godot 4.2.2 
class_name Ant extends CharacterBody2D

@onready var sprite := $Sprite2D
@export var factor: float = 0.5
@onready var ant := $"."
var path := []
@onready var nav_point := preload ("res://Scenes/nav_point.tscn")
@onready var pheromone := preload ("res://Scenes/pheromone.tscn")
@onready var nozzle = $Sprite2D/Nozzle
var ant_color = null
#var move_direction = Vector2.ZERO

var current_food_target = null
var last_pheromone_position: Vector2 = Vector2.ZERO

func _ready() -> void:
    create_ant_path_color()

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
        sprite.modulate = Color(0, 1, 0, 1)

func drop_nav_point():
    var new_nav_point = nav_point.instantiate()
    new_nav_point.global_position = nozzle.global_position
    new_nav_point.owner_ant = self
    new_nav_point.set_color(ant_color)
    #new_nav_point.connect("ant_entered", Callable(self, "_on_nav_point_entered"))
    get_parent().add_child(new_nav_point)

func drop_pheromone():
    if can_drop_pheromone():
        var new_pheromone = pheromone.instantiate()
        new_pheromone.global_position = nozzle.global_position
        get_parent().add_child(new_pheromone)
        last_pheromone_position = nozzle.global_position

func can_drop_pheromone() -> bool:
    if last_pheromone_position == null:
        return true
    var max_diameter = Pheromone.MAX_RADIUS * 2
    var current_distance = nozzle.global_position.distance_to(last_pheromone_position)
    return current_distance > max_diameter

func create_ant_path_color():
    var path_color = Color(randf(), randf(), randf())
    ant_color = path_color


