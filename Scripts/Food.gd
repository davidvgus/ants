#godot 4.2.2
class_name Food extends Area2D

signal ant_entered

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    connect("body_entered", Callable(self, "_on_body_entered"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func _on_body_entered(body: Node) -> void:
    if body is Ant:
        ant_entered.emit(body, self)
