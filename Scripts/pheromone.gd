#Godot 4.2.2
class_name Pheromone extends Area2D

#@onready var count: int = 0 # Variable to keep track of overlaps
@onready var creation_time
var strength: float = 50.0
var evaporation_rate: float = 10.0
const MIN_RADIUS: float = 0.1
const MAX_RADIUS: float = 10.0

func _ready() -> void:
    add_to_group("pheromones")
    creation_time = Time.get_unix_time_from_system()
    connect("area_entered", Callable(self, "_on_Pheromone_area_entered"))
    connect("body_entered", Callable(self, "_on_body_entered"))
    connect("body_exited", Callable(self, "_on_body_exited"))

func _process(delta: float) -> void:
    strength -= evaporation_rate * delta
    if strength <= 0:
        queue_free()
    else:
        # Assuming the original size corresponds to a diameter of 26 at strength 100
        var max_strength = 100.0
        var original_diameter = 26.0
        var max_scale = original_diameter / 26.0 # This would be 1 if original diameter is 26
        var scale_factor = max(strength / max_strength, 0.1) * max_scale
        scale = Vector2(scale_factor, scale_factor)

func _on_Pheromone_area_entered(area: Area2D) -> void:
    if area is Pheromone:
        if creation_time < area.creation_time:
            strength += 50.0
            #be careful
            pass
        else:
           area.queue_free()

func _on_body_entered(body: Node2D) -> void:
    if body is Ant:
        body.tasted_pheromone(self)
        pass
func _on_body_exited(body: Node2D) -> void:
    if body is Ant:
        body.stopped_tasting_pheromone(self)
        pass

static func get_min_radius() -> float:
    return MIN_RADIUS

static func get_max_radius() -> float:
    return MAX_RADIUS
