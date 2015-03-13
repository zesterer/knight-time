namespace knightmare
{
	int mmain(string[] args)
	{
		//Set the core engine up
		Core.Piece.setup();
		
		//Test board
		Core.Game game = new Core.Game();
		game.current_board.setup();
		
		while (true)
		{
			//Display the board
			stdout.printf(game.current_board.termOutput());
			
			//Get user input
			string[4] parts = {"0", "0", "0", "0"};
			//parts = stdin.read_line().split(" ");
			
			stdin.read_line();
			
			//Exit if needed
			if (parts[0] == "exit")
				break;
			
			//Make the move
			Core.Move move = new Core.Move(game.current_board, (int8)int.parse(parts[0]), (int8)int.parse(parts[1]), (int8)int.parse(parts[2]), (int8)int.parse(parts[3]));
			move.apply();
			
			game.current_board.moveRandom();
		}
		
		return 0;
	}
}
