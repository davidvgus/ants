#Godot 4.2.2
extends Node
@export var create_ants: bool = false
@export var ant_release_delay: float = 0.25
@export var max_ants: int = 10
var act: float = 0
@onready var pheremones_node := $pheremones
@onready var slider := $UI/Time

@export var enable_nav_points: bool = false

func _ready() -> void:
    #print("print in game.gd _ready")
    pass

func _process(delta: float) -> void:
    act += delta
    if act > ant_release_delay&&create_ants&&$Ants.get_child_count() < max_ants:
        act = 0
        var ant_scene = load("res://Scenes/ant.tscn")
        var ant_instance = ant_scene.instantiate()
        $Ants.add_child(ant_instance)
        ant_instance.global_position = $AndCreationLocation.global_position

func _unhandled_input(event) -> void:
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
        var pheromone = load("res://Scenes/pheromone.tscn")
        var new_pheromone = pheromone.instantiate()
        pheremones_node.add_child(new_pheromone)
        new_pheromone.global_position = get_viewport().get_mouse_position()

    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
        var ant_scene = load("res://Scenes/ant.tscn")
        var ant_instance = ant_scene.instantiate()
        $Ants.add_child(ant_instance)
        ant_instance.global_position = get_viewport().get_mouse_position()
