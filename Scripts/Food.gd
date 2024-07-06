#godot 4.2.2
class_name Food extends Area2D
@export var food_amout: int = 1

signal ant_entered

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    connect("body_entered", Callable(self, "_on_body_entered"))

func _process(delta: float) -> void:
    if food_amout <= 0:
        #queue_free()
        set_collision_layer_value(0, false) # Assuming it's on the first layer
        set_collision_mask_value(0, false) # Assuming it affects the first layer
        # Make the node invisible
        visible = false
        disconnect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
    if body is Ant:
        food_amout -= 1
        ant_entered.emit(body, self)
