extends Node

#Godot 4.2.2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func _input(event) -> void:
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
        var food = get_node("Food") # Make sure the path to the Food node is correct.
        if food:
            food.global_position = get_viewport().get_mouse_position()

    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
        var ant_scene = load("res://Scenes/ant.tscn")
        var ant_instance = ant_scene.instantiate()
        add_child(ant_instance)
        ant_instance.global_position = get_viewport().get_mouse_position()
