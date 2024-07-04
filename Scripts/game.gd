extends Node

var ant_delay: float = 0.25
var act: float = 0

#@onready var ands_dir := {}
#Godot 4.2.2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    act += delta
    print(act)
    if act > ant_delay:
        print("Creating Ant")
        act = 0
        var ant_scene = load("res://Scenes/ant.tscn")
        var ant_instance = ant_scene.instantiate()
        $Ants.add_child(ant_instance)
        ant_instance.global_position = $AndCreationLocation.global_position

func _input(event) -> void:
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
        var food = get_node("Food") # Make sure the path to the Food node is correct.
        if food:
            food.global_position = get_viewport().get_mouse_position()

    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
        var ant_scene = load("res://Scenes/ant.tscn")
        var ant_instance = ant_scene.instantiate()
        $Ants.add_child(ant_instance)
        ant_instance.global_position = get_viewport().get_mouse_position()
