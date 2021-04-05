extends Area2D

export var firerate := 1.0
export (PackedScene) var projectileScene

var lastTimeFired := 0.0

func _process(delta):
	lastTimeFired += delta
	if lastTimeFired > firerate:
		var newProjectile = projectileScene.instance()
		newProjectile.direction = Vector2.UP
		add_child(newProjectile)
		lastTimeFired = 0.0
		
		
