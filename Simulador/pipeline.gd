extends Node

var instructions = []
var current_cycle = 0
var bubble_count = 0

# Dicionário simples pra simular memória
var memory = {}

# Dicionário simples para simular banco de registradores
var registers = {
	"x0" = 0,	"x1" = 0,	"x2" = 0,	"x3" = 0,	"x4" = 0,	"x5" = 0,	"x6" = 0,	"x7" = 0,
	"x8" = 0,	"x9" = 0,	"x10" = 0,	"x11" = 0,	"x12" = 0,	"x13" = 0,	"x14" = 0,	"x15" = 0,
}

func initialize():
	instructions.clear()
	current_cycle = 0
	bubble_count = 0
	registers = {
	"x0" = 0,	"x1" = 1,	"x2" = 2,	"x3" = 3,	"x4" = 4,	"x5" = 5,	"x6" = 6,	"x7" = 7,
	"x8" = 8,	"x9" = 9,	"x10" = 10,	"x11" = 11,	"x12" = 12,	"x13" = 13,	"x14" = 14,	"x15" = 15,
	} # TODO Colocar tudo 0 de volta
	memory.clear()
	
func load_instructions(new_instructions):
	instructions = new_instructions

func execute_cycle():
	if instructions.is_empty():
		return
	
	var instruction = instructions.pop_front()
	execute_instruction(instruction)
	
	
func load_from_memory(address):
	return memory.get(address, 0)
	
func store_to_memory(address, value):
	memory[address] = value
		
func execute_instruction(instruction):
	match instruction["type"]:
		"ADD":
			var rd = instruction["rd"]
			var rs1 = instruction["rs1"]
			var rs2 = instruction["rs2"]
			registers[rd] = registers.get(rs1, 0) + registers.get(rs2, 0)
			current_cycle += 1
		"SUB":
			var rd = instruction["rd"]
			var rs1 = instruction["rs1"]
			var rs2 = instruction["rs2"]
			registers[rd] = registers.get(rs1, 0) - registers.get(rs2, 0)
			current_cycle += 1
		"LW":
			var rd = instruction["rd"]
			var rs1 = instruction["rs1"]
			var offset = instruction["offset"]
			registers[rd] = load_from_memory(registers.get(rs1, 0) + offset)
			current_cycle += 2
		"SW":
			var rs1 = instruction["rs1"]
			var rs2 = instruction["rs2"]
			var offset = instruction["offset"]
			store_to_memory(registers.get(rs1, 0) + offset, registers.get(rs2, 0))
			current_cycle += 2
		"MUL":
			var rd = instruction["rd"]
			var rs1 = instruction["rs1"]
			var rs2 = instruction["rs2"]
			registers[rd] = registers.get(rs1, 0) * registers.get(rs2, 0)
			current_cycle += 2
		"DIV":
			var rd = instruction["rd"]
			var rs1 = instruction["rs1"]
			var rs2 = instruction["rs2"]
			registers[rd] = registers.get(rs1, 0) / registers.get(rs2, 0)
			current_cycle += 2
		# TODO Instrução de desvio bleh
		"bolha":
			pass
		_:
			pass
