namespace knightmare
{
	namespace Core
	{
		public class Board : Object
		{
			public int8[,] data;
			
			public Board()
			{
				this.data = new int8[board_size, board_size];
				this.setup();
			}
			
			public int8 get(int8 x, int8 y)
			{
				return this.data[x, y];
			}
			
			public void setup()
			{
				//Empty the board
				for (int8 y = 0; y < board_size; y ++)
				{
					for (int8 x = 0; x < board_size; x ++)
					{
						this.data[x, y] = 0x00;
					}
				}
				
				//~~~~BLACK PIECES~~~~
				
				//Pawns, top row
				for (int count = 0; count < board_size; count ++)
					this.data[count, 1] = 0x01;
				
				//Other pieces, top row
				this.data[0, 0] = 0x02;
				this.data[1, 0] = 0x03;
				this.data[2, 0] = 0x04;
				this.data[3, 0] = 0x05;
				this.data[4, 0] = 0x06;
				this.data[5, 0] = 0x04;
				this.data[6, 0] = 0x03;
				this.data[7, 0] = 0x02;
				
				//~~~~WHITE PIECES~~~~
				
				//Pawns, bottom row
				for (int count = 0; count < board_size; count ++)
					this.data[count, 6] = 0x07;
				
				//Other pieces, bottom row
				this.data[0, 7] = 0x08;
				this.data[1, 7] = 0x09;
				this.data[2, 7] = 0x0A;
				this.data[3, 7] = 0x0C;
				this.data[4, 7] = 0x0B;
				this.data[5, 7] = 0x0A;
				this.data[6, 7] = 0x09;
				this.data[7, 7] = 0x08;
			}
			
			public string termOutput()
			{
				string message = "╔════════╗\n";
				
				for (int8 y = 0; y < board_size; y ++)
				{
					message += "║";
					
					for (int8 x = 0; x < board_size; x ++)
					{
						if (this.data[x, y] > 0x00)
							message += Piece.pieces[this.data[x, y]].character;
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
