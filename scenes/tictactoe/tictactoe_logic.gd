class_name tictactoeLogic
extends Node


const LINES = [
	
	# Horizontal
	[0,1,2],[3,4,5],[6,7,8],
	
	# Vertical
	[0,3,6],[1,4,7],[2,5,8],

	# Diagonal
	[0,4,8],[2,4,6]
]


static func check_result(board:Array):
	for line in LINES:
		var a:String = board[line[0]]
		if a != "" and a== board[line[1]] and  a == board[line[2]]:
			if a=="x":
				return "x"
			else:
				return "o"
	if not board.has(""):
		return "draw"
