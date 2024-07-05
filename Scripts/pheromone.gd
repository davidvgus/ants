#Godot 4.2.2
class_name Pheromone extends Area2D

@onready var count: int = 0 # Variable to keep track of overlaps
@onready var creation_time

func _ready() -> void:
    creation_time = Time.get_unix_time_from_system()
    connect("area_entered", Callable(self, "_on_Pheromone_area_entered"))

func _on_Pheromone_area_entered(area: Area2D) -> void:
    print("Pheromone area entered")
    if area is Pheromone:
        if creation_time < area.creation_time:
            count += 1
        else:
            area.queue_free()
