#Godot 4.2.2
class_name NavPoint extends Area2D
@onready var sprite := $Sprite2D

var can_free = false
var owner_ant = null

signal ant_entered
signal ant_exited

func _ready() -> void:
    connect("body_entered", Callable(self, "_on_body_entered"))
    connect("body_exited", Callable(self, "_on_body_exited"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func _on_body_entered(body: Node) -> void:
    if body is Ant:
        ant_entered.emit(body)
        if can_free&&owner_ant == body:
            queue_free()

func _on_body_exited(body: Node) -> void:
    if body is Ant:
        can_free = true

func set_color(ant_color) -> void:
    sprite = $Sprite2D
    sprite.modulate = ant_color
