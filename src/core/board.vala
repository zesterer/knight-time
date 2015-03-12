namespace knightmare
{
	namespace Core
	{
		public class Board : Object
		{
			public int8[,] data = new int8[8, 8];
			
			public Board()
			{
				this.clear();
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
			
			public new Board clone()
			{
				Board new_board = new Board();
				
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
