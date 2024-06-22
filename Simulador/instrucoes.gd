extends Node

var instruction_set = [
		{"type": "ADD", "rd": "x1", "rs1": "x2", "rs2": "x3"}, # x1 = x2 + x3
		{"type": "SUB", "rd": "x4", "rs1": "x1", "rs2": "x5"}, # x4 = x1 - x5 (dependência verdadeira em x1)
		{"type": "LW", "rd": "x6", "rs1": "x1", "offset": 0}, # x6 = MEM[x1 + 0] (dependência verdadeira em x1)
		{"type": "SW", "rs2": "x7", "rs1": "x6", "offset": 0},# MEM[x6 + 0] = x7 (dependência verdadeira em x6)
		{"type": "bolha"}, # Bolha
		{"type": "ADD", "rd": "x1", "rs1": "x6", "rs2": "x8"}, # x1 = x6 + x8 (WAR - x1 lido e escrito antes)
		{"type": "SUB", "rd": "x6", "rs1": "x9", "rs2": "x10"}, # x6 = x9 - x10 (WAW - x6 escrito antes)
		{"type": "MUL", "rd": "x6", "rs1": "x9", "rs2": "x10"}, # 
		{"type": "bolha", "rd": "x6", "rs1": "x9", "rs2": "x10"}, # 
		{"type": "DIV", "rd": "x6", "rs1": "x9", "rs2": "x10"} # 
	]

func get_instructions():
	return instruction_set
