namespace knightmare
{
	int main(string[] args)
	{
		//Set the core engine up
		Core.Piece.setup();
		
		//Test board
		Core.Board board = new Core.Board();
		board.setup();
		
		//Create a test piece
		board.data[0, 1] = 0x00;
		board.data[3, 4] = 0x01;
		
		//Test move
		Core.Move move = {board, 0, 0, 0, 4};
		move.apply();
		move = {board, 0, 4, 5, 4};
		move.apply();
		
		while (true)
		{
			//Display the board
			stdout.printf(board.termOutput());
			
			//Get user input
			string[4] parts = {"0", "0", "0", "0"};
			parts = stdin.read_line().split(" ");
			
			//Exit if needed
			if (parts[0] == "exit")
				break;
			
			//Make the move!
			move = {board, (int8)int.parse(parts[0]), (int8)int.parse(parts[1]), (int8)int.parse(parts[2]), (int8)int.parse(parts[3])};
			move.apply();
		}
		
		return 0;
	}
}
