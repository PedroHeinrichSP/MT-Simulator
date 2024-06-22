extends Node

var ipc: float
var cycles: int
var bubbles: int

func reset():
	ipc = 0.0
	cycles = 0
	bubbles = 0
	
func collect(pipeline):
	# Coletar as métricas de um pipeline
	cycles = pipeline.current_cycle
	bubbles = pipeline.bubble_count
	ipc = calculate_ipc(pipeline)
	pass # TODO
	
func calculate_ipc(pipeline):
	# Supondo que as instruções totais executadas são a soma das instruções normais e das bolhas
	var total_instructions = pipeline.instructions.size()
	if cycles == 0:
		return 0.0
	return float (total_instructions / cycles)
	
