namespace knightmare
{
	namespace Core
	{
		public struct Move
		{
			public Board board;
			public int8 from_x;
			public int8 from_y;
			public int8 to_x;
			public int8 to_y;
			
			public int8 getPiece()
			{
				return this.board.data[this.from_x, this.from_y];
			}
			
			public int8 getTarget()
			{
				return this.board.data[this.to_x, to_y];
			}
			
			public void apply()
			{
				if (this.isValid())
				{
					this.board.data[this.to_x, this.to_y] = this.board.data[this.from_x, this.from_y];
					this.board.data[this.from_x, this.from_y] = 0x00;
				}
			}
			
			public bool isValid()
			{
				//Find the piece kind
				int8 piece = this.getPiece();
				//Find the colour of the piece
				Piece.Colour colour;
				if (piece != 0x00)
					colour = Piece.pieces[piece].colour;
				else
					colour = Piece.Colour.NONE;
				
				//VS is the Vector Scalar. Positions are multiplied by this
				//such that when vs = -1, all checks are done as if the other
				//side of the board is being played
				int8 vs;
				if (colour == Piece.Colour.BLACK)
					vs = 1;
				else
					vs = -1;
				
				//Check for each piece kind
				if ((piece == 0x01 && colour == Piece.Colour.BLACK) || (piece == 0x07 && colour == Piece.Colour.WHITE))
				{
					//It's a pawn
					return true;
				}
				else if ((piece == 0x02 && colour == Piece.Colour.BLACK) || (piece == 0x08 && colour == Piece.Colour.WHITE))
				{
					//It's a rook
					return true;
				}
				else if ((piece == 0x03 && colour == Piece.Colour.BLACK) || (piece == 0x09 && colour == Piece.Colour.WHITE))
				{
					//It's a knight
					return true;
				}
				else if ((piece == 0x04 && colour == Piece.Colour.BLACK) || (piece == 0x0A && colour == Piece.Colour.WHITE))
				{
					//It's a bishop
					return true;
				}
				else if ((piece == 0x05 && colour == Piece.Colour.BLACK) || (piece == 0x0B && colour == Piece.Colour.WHITE))
				{
					//It's a queen
					return true;
				}
				else if ((piece == 0x06 && colour == Piece.Colour.BLACK) || (piece == 0x0C && colour == Piece.Colour.WHITE))
				{
					//It's a king
					return true;
				}
				else
				{
					knightmare.Common.output("Move invalid!");
					return false; //By default, assume that the move is invalid
				}
			}
		}
	}
}
