namespace knightmare
{
	namespace Core
	{
		public class Move
		{
			public Board board;
			public int8 from_x;
			public int8 from_y;
			public int8 to_x;
			public int8 to_y;
			
			public Move(Board board, int8 from_x, int8 from_y, int8 to_x, int8 to_y)
			{
				this.board = board;
				this.from_x = from_x;
				this.from_y = from_y;
				this.to_x = to_x;
				this.to_y = to_y;
			}
			
			public int8 getPieceID()
			{
				return this.board.data[this.from_x, this.from_y];
			}
			
			public int8 getTargetID()
			{
				return this.board.data[this.to_x, to_y];
			}
			
			public unowned Piece.Piece? getPiece()
			{
				return Piece.kind[this.getPieceID()];
			}
			
			public unowned Piece.Piece? getTarget()
			{
				return Piece.kind[this.getTargetID()];
			}
			
			public bool isValidPotential()
			{
				//Find the movement positions
				int8 fx = this.from_x; //From x - the x position of the piece being moved
				int8 fy = this.from_y; //From y - the y position of the piece being moved
				int8 tx = this.to_x; //To x - the x position of the piece being taken
				int8 ty = this.to_y; //To y - the y position of the piece being taken
				int8 rx = tx - fx; //Relative change in x position
				int8 ry = ty - fy; //Relative change in y position
				int8 dx = (int8)((int)rx).abs(); //Scalar change in x position
				int8 dy = (int8)((int)ry).abs(); //Scalar change in y position
				int8 ux = rx.clamp(-1, 1); //Unit change in x position
				int8 uy = ry.clamp(-1, 1); //Unit change in y position
				
				if (fx < 0 || fx > 7 || fy < 0 || fy > 7 || tx < 0 || tx > 7 || ty < 0 || ty > 7)
				{ //Coordinates are outside the board
					return false;
				}
				
				//Find the pieces we are moving, and the pieces we are moving to
				unowned Piece.Piece? piece = this.getPiece();
				unowned Piece.Piece? target = this.getTarget();
				
				//Make sure we're actually trying to move a piece
				if (piece == null)
					return false;
				
				if (fx == tx && fy == ty)
				{ //It's not moved
					return false;
				}
				
				//The vector multiplier - points in the direction of the piece team
				int8 vm;
				if (piece.colour == Piece.Colour.BLACK)
					vm = 1;
				else
					vm = -1;
				
				switch(piece.kind)
				{
					case (Piece.Kind.PAWN):
						{
							if (ry * vm == 1)
							{ //Moved forward one place
								if (rx == 0 && target == null)
								{ //Moved into the cell above
									return true;
								}
								else if (dx == 1 && target != null && target.colour != piece.colour)
								{//Taking a piece diagonally
									return true;
								}
							}
							else if (ry * vm == 2 && rx == 0 && target == null && ((vm == 1 && fy == 1) || (vm == -1 && fy == 6)))
							{ //Starting from initial position (jump of 2)
								if (this.board.checkFree(fx, fy, 0, vm, 2))
								{ //Nothing in the way
									return true;
								}
							}
							
							break;
						}
					case (Piece.Kind.ROOK):
						{
							if (dx == 0 || dy == 0)
							{ //Moving in a cartesian manner
								if (this.board.checkFree(fx, fy, ux, uy, dx + dy) == false)
								{ //There's something in the way
									return false;
								}
								else if (target != null)
								{ //Moving into a space with an opponent
									if (target.colour != piece.colour)
									{ //The target is an opponent
										return true;
									}
								}
								else
								{ //moving into an empty space
									return true;
								}
							}
							
							break;
						}
					case (Piece.Kind.KNIGHT):
						{
							if (dx + dy == 3 && int8.max(dx, dy) == 2)
							{ //Moving in a knight-like manner
								if (target != null)
								{ //Moving into a space with an opponent
									if (target.colour != piece.colour)
									{ //The target is an opponent
										return true;
									}
								}
								else
								{ //moving into an empty space
									return true;
								}
							}
							
							break;
						}
					case (Piece.Kind.BISHOP):
						{
							if (dx == dy)
							{ //Moving in a diagonal manner
								if (this.board.checkFree(fx, fy, ux, uy, dx) == false)
								{ //There's something in the way
									return false;
								}
								else if (target != null)
								{ //Moving into a space with an opponent
									if (target.colour != piece.colour)
									{ //The target is an opponent
										return true;
									}
								}
								else
								{ //moving into an empty space
									return true;
								}
							}
							
							break;
						}
					case (Piece.Kind.QUEEN):
						{
							if (dx == dy || (dx == 0 || dy == 0))
							{ //Moving in a diagonal manner
								bool free = false;
								
								if (dx == dy)
								{ //It's moving like a bishop
									free = this.board.checkFree(fx, fy, ux, uy, dx);
								}
								else
								{ //It's moving like a rook
									free = this.board.checkFree(fx, fy, ux, uy, dx + dy);
								}
								
								if (free == false)
								{ //Route is blocked
									return false;
								}
								else if (target != null)
								{ //Moving into a space with an opponent
									if (target.colour != piece.colour)
									{ //The target is an opponent
										return true;
									}
								}
								else
								{ //moving into an empty space
									return true;
								}
							}
							
							break;
						}
					case (Piece.Kind.KING):
						{
							if (int8.max(dx, dy) <= 1 && (dx == dy || (dx == 0 || dy == 0)))
							{ //Moving in a diagonal manner
								bool free = false;
								
								if (dx == dy)
								{ //It's moving like a bishop
									free = this.board.checkFree(fx, fy, ux, uy, dx);
								}
								else
								{ //It's moving like a rook
									free = this.board.checkFree(fx, fy, ux, uy, dx + dy);
								}
								
								if (free == false)
								{ //Route is blocked
									return false;
								}
								else if (target != null)
								{ //Moving into a space with an opponent
									if (target.colour != piece.colour)
									{ //The target is an opponent
										return true;
									}
								}
								else
								{ //moving into an empty space
									return true;
								}
							}
							
							break;
						}
					default:
						return false;
				}
				
				//If all else fails, default to false as a failsafe
				return false;
			}
			
			public bool isValidWithTurn()
			{
				unowned Piece.Piece? piece = this.getPiece();
				
				if (piece == null)
					return false;
				
				if (piece.colour != this.board.turn)
					return false;
				
				return this.isValidPotential();
			}
			
			public bool isValidWithCheck()
			{
				Board board = this.board.clone();
				Move move = new Move(board, this.from_x, this.from_y, this.to_x, this.to_y);
				move.applyNoCheck();
				
				if (board.isInCheck(this.getPiece().colour))
					return false;
				
				return true;
			}
			
			public void applyNoCheck()
			{
				this.board.data[to_x, to_y] = this.board.data[from_x, from_y];
				this.board.data[from_x, from_y] = 0x00;
				this.board.turn = (this.board.turn == Piece.Colour.BLACK) ? Piece.Colour.WHITE : Piece.Colour.BLACK;
				this.board.not_turn = (this.board.not_turn == Piece.Colour.BLACK) ? Piece.Colour.WHITE : Piece.Colour.BLACK;
				
				if (this.board.turn == Piece.Colour.BLACK)
					stdout.printf("Switched to black.\n");
				else
					stdout.printf("Switched to white.\n");
				
				this.board.updated();
			}
			
			public bool apply()
			{
				if (this.isValidWithTurn())
				{
					//Board board = this.board.clone();
					//Move move = new Move(board, this.from_x, this.from_y, this.to_x, this.to_y);
					//move.applyNoCheck();
					
					if (!this.isValidWithCheck())
					{
						stdout.printf("WE'RE IN CHECK!\n");
						return false;
					}
					
					this.applyNoCheck();
					
					return true;
				}
				else
				{
					Common.output("Move validation failed");
					return false;
				}
			}
		}
	}
}
