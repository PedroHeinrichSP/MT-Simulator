extends Node

var ipc: float
var cycles: int
var bubbles: int
var is_running: bool = false

# Componentes do simulador
var pipeline = preload("res://Simulador/pipeline.gd").new()
var instrucoes = preload("res://Simulador/instrucoes.gd").new()
var metricas = preload("res://Simulador/metricas.gd").new()

func start_simulation():		
	is_running = true
	pipeline.initialize()
	pipeline.load_instructions(instrucoes.get_instructions())
	metricas.reset()
	
func pause_simulation():
	is_running = !is_running

func update(delta):
	if not is_running:
		return
	
	# Atualizar a execução do pipeline e coletar métricas
	pipeline.execute_cycle()
	metricas.collect(pipeline)
	
	# Atualizar métricas
	ipc = metricas.ipc
	cycles = metricas.cycles
	bubbles = metricas.bubbles
	
	
	
func get_ipc():
	return ipc
	
func get_cycles():
	return cycles

func get_bubbles():
	return bubbles

