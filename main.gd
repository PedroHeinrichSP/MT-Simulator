extends Node

@onready var simulador = $Simulador
@onready var ui = $UI

# Chamado quando o node entra na árvore pela primeira vez
func _ready():
	# Conectar sinais da UI
	ui.connect("start_simulation", Callable(self, "_on_start_simulation"))
	ui.connect("pause_simulation", Callable(self, "_on_pause_simulation"))

func _on_start_simulation():
	simulador.start_simulation()
	
func _on_pause_simulation():
	simulador.pause_simulation()
	if simulador.is_running:
		ui.pause_button.text = "Continue"
	else: ui.pause_button.text = "Pause"
	
# 'delta' é o tempo desde o frame anterior.
func _process(delta):
	if simulador.is_running:
		simulador.update(delta)
		update_ui()
		
func update_ui():
	ui.update_metrics(simulador.get_ipc(), simulador.get_cycles(), simulador.get_bubbles())
	ui.update_registers(simulador.pipeline.registers)
	
