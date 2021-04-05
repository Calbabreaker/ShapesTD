extends PathFollow2D

export var speed := 10
export (Array, PackedScene) var spawnWhenDie := []

func _process(delta):
	set_offset(get_offset() + speed * delta)
	
	if not loop and get_unit_offset() == 1:
		queue_free()


func _on_Area2D_area_entered(projectile):
	# don't need to check if projectile because on projectile collision layer
	if projectile.pierce <= 0:
		return
	
	projectile.pierce -= 1
	if projectile.pierce <= 0:
		projectile.queue_free()
	
	var offsetPos := 0
	for shapeScene in spawnWhenDie:
		var shape = shapeScene.instance()
		shape.set_offset(get_offset() - offsetPos)
		get_parent().add_child(shape)
		offsetPos += 20
	queue_free()
