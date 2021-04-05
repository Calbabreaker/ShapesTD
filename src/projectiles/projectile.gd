extends Area2D

export var speed := 10.0
export var lifetime := 0.1
export var pierce := 1

var direction: Vector2
var time := 0.0

func _process(delta):
	position += direction * (delta * speed)
	time += delta
	
	if time > lifetime:
		queue_free()
