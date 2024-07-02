class_name State extends Node

signal transitioned(state: State, new_state_name: String)

func Enter() -> void:
    pass

func Exit() -> void:
    pass

func Update(_delta: float) -> void:
    pass

func Physics_Update(_delta: float) -> void:
    pass
