extends Path2D

export var timePerSpacing := 0.01

var waveData := preload("res://src/wave_data.gd").new()
var waves = waveData.get("waves")

var waveNumber := 0
var shapeCollectionIndex := 0
var spawnedCurrentCollection := 0
var lastSpawnTime := 0.0

func _process(delta):
	var currentCollec = waves[waveNumber][shapeCollectionIndex]
	var spawnRate: float = currentCollec.spacing * timePerSpacing

	while lastSpawnTime > spawnRate:
		# time to spawn!
		if currentCollec.shape > -1:
			add_child(waveData.shapeScenes[currentCollec.shape].instance())
		spawnedCurrentCollection += 1
		
		if spawnedCurrentCollection > currentCollec.count:
			# finished the current collection of shapes
			spawnedCurrentCollection = 0
			shapeCollectionIndex += 1
			
			if shapeCollectionIndex >= len(waves[waveNumber]):
				# finished the wave
				shapeCollectionIndex = 0
				waveNumber += 1 
				
				if waveNumber >= len(waves):
					set_process(false)
					break;
		
		lastSpawnTime -= spawnRate

	lastSpawnTime += delta
