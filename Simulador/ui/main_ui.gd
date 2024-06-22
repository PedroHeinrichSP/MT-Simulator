extends Control

signal start_simulation
signal pause_simulation
signal method_selected
signal architecture_selected

@onready var start_button = $StartButton
@onready var pause_button = $PauseButton
@onready var ipc_label = $IPCLabel
@onready var cycle_label = $CycleLabel
@onready var bubble_label = $BubbleLabel
@onready var registers_value = $RegistersValue
@onready var method_option = $MethodOption
@onready var architecture_option = $ArchitectureOption
@onready var architecture_label = $ArchitectureLabel

func _ready():
	start_button.connect("pressed", Callable(self, "_on_start_button_pressed"))
	pause_button.connect("pressed", Callable(self, "_on_pause_button_pressed"))
	method_option.connect("item_selected", Callable(self, "_on_method_selected"))
	architecture_option.connect("toggled", Callable(self, "_on_architecture_toggled"))
	
	method_option.add_item("Referência", 0)
	method_option.add_item("SMT", 1)
	method_option.add_item("IMT", 2)
	method_option.add_item("BMT", 3)
	
func _on_start_button_pressed():
	emit_signal("start_simulation")
	
func _on_pause_button_pressed():
	emit_signal("pause_simulation")
	
func _on_method_selected(index):
	var method = method_option.get_item_text(index)
	emit_signal("method_selected", method)
	
func _on_architecture_toggled(button_pressed):
	if architecture_option.button_pressed:
		architecture_label.text = "Superescalar"
	else: architecture_label.text = "Escalar"
	emit_signal("architecture_selected", button_pressed)
	
func update_metrics (ipc, cycles, bubbles):
	ipc_label.text = "IPC: " + str(ipc)
	cycle_label.text = "Ciclos: " + str(cycles)
	bubble_label.text = "Bolhas: " + str(bubbles)
	
func update_registers(registers):
	var registers_text = ""
	for reg in registers.keys():
		registers_text += reg + ": " + str(registers[reg]) + "\n"
		registers_value.text = registers_text

