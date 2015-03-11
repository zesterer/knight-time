namespace knightmare
{
	int main(string[] args)
	{
		//Set things up
		Core.Piece.setup();
		
		Core.Board board = new Core.Board();
		Core.Move move = {board, 1, 2, 1, 3};
		move.apply();
		
		stdout.printf(board.termOutput());
		
		return 0;
	}
}
