class_name Ant extends CharacterBody2D

@onready var sprite := $Sprite2D

func _physics_process(delta: float) -> void:
    move_and_slide()
    if velocity.length() > 0:
        sprite.rotation = velocity.angle()
