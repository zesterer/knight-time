namespace knightmare
{
	namespace Core
	{
		public class Board : Object
		{
			public int8[,] data = new int8[8, 8];
			public Piece.Colour turn;
			public Piece.Colour not_turn;
			
			public signal void updated();
			
			public Board()
			{
				this.clear();
				this.turn = Piece.Colour.WHITE;
				this.not_turn = Piece.Colour.BLACK;
			}
			
			public void clear()
			{
				//Clear the board
				for (int8 y = 0; y < 8; y ++)
				{
					for (int8 x = 0; x < 8; x ++)
					{
						this.data[x, y] = 0x00;
					}
				}
			}
			
			public DynamicList<Core.Move> getPossibleMoves(Core.Piece.Colour colour = this.turn)
			{
				DynamicList<int16> pieces = this.getPieces(colour);
				DynamicList<Move?> moves = new DynamicList<Move?>();
				
				for (int16 count = 0; count < pieces.length; count ++)
				{
					DynamicList<Move?> potentials = this.getPieceMovesIgnoreCheck((int8)(pieces[count] % 256), (int8)(pieces[count] / 256));
					for (int16 count2 = 0; count2 < potentials.length; count2 ++)
					{
						if (potentials[count2].isValidPotential())
						{
							moves.add(potentials[count2]);
						}
					}
				}
				
				return moves;
			}
			
			public bool moveRandom()
			{
				DynamicList<Core.Move> moves = this.getPossibleMoves();
				
				if (moves.length < 1)
					return false;
				
				int16 n = (int16)Random.int_range(0, moves.length);
				return moves[n].apply();
			}
			
			public bool isInCheck(Core.Piece.Colour colour = this.turn)
			{
				DynamicList<Core.Move> potential_moves;
				
				Core.Piece.Colour opposite;
				
				if (colour == Core.Piece.Colour.BLACK)
					opposite = Core.Piece.Colour.WHITE;
				else
					opposite = Core.Piece.Colour.BLACK;
				
				potential_moves = this.getPossibleMoves(opposite);
				
				//Find the king location
				for (int8 x = 0; x < 8; x ++)
				{
					for (int8 y = 0; y < 8; y ++)
					{
						Core.Piece.Piece? piece = Core.Piece.kind[this.data[x, y]];
						if (piece != null)
						{
							if (piece.colour == colour && piece.kind == Core.Piece.Kind.KING)
							{
								//stdout.printf("Found the king at %s, %s!\n", x.to_string(), y.to_string());
							
								for (int count = 0; count < potential_moves.length; count ++)
								{
									if (potential_moves[count].to_x == x && potential_moves[count].to_y == y)
									{
										return true;
									}
								}
							}
						}
					}
				}
				
				return false;
			}
			
			public DynamicList<int16> getPieces(Piece.Colour colour)
			{
				DynamicList<int16> piece_list = new DynamicList<int16>();
				
				for (int8 y = 0; y < 8; y ++)
				{
					for (int8 x = 0; x < 8; x ++)
					{
						if (this.data[x, y] != 0x00 && Piece.kind[this.data[x, y]].colour == colour)
						{
							piece_list.add(y * 256 + x);
						}
					}
				}
				
				return piece_list;
			}
			
			public DynamicList<Move?> getPieceMovesIgnoreCheck(int8 x, int8 y)
			{
				DynamicList<Move?> move_list = new DynamicList<Move?>();
				
				Move move;
				
				for (int8 yy = 0; yy < 8; yy ++)
				{
					for (int8 xx = 0; xx < 8; xx ++)
					{
						move = new Move(this, x, y, xx, yy);
						
						if (move.isValidPotential())
						{
							move_list.add(move);
						}
					}
				}
				
				return move_list;
			}
			
			public DynamicList<Move?> getPieceMoves(int8 x, int8 y)
			{
				DynamicList<Move?> move_list = new DynamicList<Move?>();
				
				Move move;
				
				for (int8 yy = 0; yy < 8; yy ++)
				{
					for (int8 xx = 0; xx < 8; xx ++)
					{
						move = new Move(this, x, y, xx, yy);
						
						if (move.isValidWithTurn() && move.isValidWithCheck())
						{
							move_list.add(move);
						}
					}
				}
				
				return move_list;
			}
			
			public new Board clone()
			{
				Board new_board = new Board();
				
				new_board.turn = this.turn;
				
				for (int8 y = 0; y < 8; y ++)
				{
					for (int8 x = 0; x < 8; x ++)
					{
						new_board.data[x, y] = this.data[x, y];
					}
				}
				
				return new_board;
			}
			
			public bool checkFree(int8 x, int8 y, int8 dx, int8 dy, int8 distance)
			{
				for (int8 count = 1; count < distance; count ++)
				{
					if (this.data[x + dx * count, y + dy * count] != 0x00)
					{ //Found something
						return false;
					}
				}
				
				//Found nothing, so return true
				return true;
			}
			
			public void setup()
			{
				//Clear the board
				this.clear();
        
        this.turn = Piece.Colour.WHITE;
				
				//Black pawns
				for (int8 count = 0; count < 8; count ++)
					this.data[count, 1] = 0x01;
				
				//Black pieces, top row
				this.data[0, 0] = 0x02;
				this.data[1, 0] = 0x03;
				this.data[2, 0] = 0x04;
				this.data[3, 0] = 0x05;
				this.data[4, 0] = 0x06;
				this.data[5, 0] = 0x04;
				this.data[6, 0] = 0x03;
				this.data[7, 0] = 0x02;
				
				//White pawns
				for (int8 count = 0; count < 8; count ++)
					this.data[count, 6] = 0x11;
				
				//White pieces, bottom row
				this.data[0, 7] = 0x12;
				this.data[1, 7] = 0x13;
				this.data[2, 7] = 0x14;
				this.data[3, 7] = 0x15;
				this.data[4, 7] = 0x16;
				this.data[5, 7] = 0x14;
				this.data[6, 7] = 0x13;
				this.data[7, 7] = 0x12;
			}
			
			public string termOutput()
			{
				string message = "╔════════╗\n";
				
				for (int8 y = 0; y < 8; y ++)
				{
					message += "║";
					
					for (int8 x = 0; x < 8; x ++)
					{
						if (Piece.kind[this.data[x, y]] != null)
							message += Piece.kind[this.data[x, y]].getTerminalCharacter();
						else
							message += " ";
					}
					
					message += @"║ - $(y) \n";
				}
				
				message += "╚════════╝\n ||||||||\n 01234567";
				
				return message + "\n";
			}
		}
	}
}
