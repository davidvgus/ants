#Godot 4.2.2
extends Node
@export var create_ants: bool = false
@export var ant_delay: float = 0.25
var act: float = 0
@onready var pheremones_node := $pheremones

func _ready() -> void:
    #print("print in game.gd _ready")
    pass

func _process(delta: float) -> void:
    act += delta
    if act > ant_delay&&create_ants:
        act = 0
        var ant_scene = load("res://Scenes/ant.tscn")
        var ant_instance = ant_scene.instantiate()
        $Ants.add_child(ant_instance)
        ant_instance.global_position = $AndCreationLocation.global_position

func _input(event) -> void:
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
        var pheromone = load("res://Scenes/pheromone.tscn")
        print(pheromone)
        var new_pheromone = pheromone.instantiate()
        pheremones_node.add_child(new_pheromone)
        new_pheromone.global_position = get_viewport().get_mouse_position()

    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
        var ant_scene = load("res://Scenes/ant.tscn")
        var ant_instance = ant_scene.instantiate()
        $Ants.add_child(ant_instance)
        ant_instance.global_position = get_viewport().get_mouse_position()
