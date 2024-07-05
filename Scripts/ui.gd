#godot 4.2.2 
extends Control

@onready var time_slider := $Time

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    time_slider.connect("value_changed", Callable(self, "_on_time_slider_value_changed"))

func _on_time_slider_value_changed(value: float) -> void:
    Engine.time_scale = value
