namespace knightmare
{
	namespace Core
	{
		namespace Piece
		{
			public Piece?[] kind;
			
			public void setup()
			{
				kind = new Piece?[0xFF];
				
				//Black pieces
				kind[0x01] = {Kind.PAWN,	Colour.BLACK};
				kind[0x02] = {Kind.ROOK,	Colour.BLACK};
				kind[0x03] = {Kind.KNIGHT,	Colour.BLACK};
				kind[0x04] = {Kind.BISHOP,	Colour.BLACK};
				kind[0x05] = {Kind.QUEEN,	Colour.BLACK};
				kind[0x06] = {Kind.KING,	Colour.BLACK};
				
				//White pieces
				kind[0x11] = {Kind.PAWN,	Colour.WHITE};
				kind[0x12] = {Kind.ROOK,	Colour.WHITE};
				kind[0x13] = {Kind.KNIGHT,	Colour.WHITE};
				kind[0x14] = {Kind.BISHOP,	Colour.WHITE};
				kind[0x15] = {Kind.QUEEN,	Colour.WHITE};
				kind[0x16] = {Kind.KING,	Colour.WHITE};
			}
			
			public struct Piece
			{
				public Kind kind;
				public Colour colour;
				
				public int16 getPieceValue()
				{
					switch (this.kind)
					{
						case (Kind.PAWN):
							return 1;
						case (Kind.ROOK):
							return 6;
						case (Kind.KNIGHT):
							return 3;
						case (Kind.BISHOP):
							return 3;
						case (Kind.QUEEN):
							return 9;
						case (Kind.KING):
							return 5000; //Some arbitarily large number
						default:
							return 1;
					}
				}
				
				public int16 getActionValue()
				{
					switch (this.kind)
					{
						case (Kind.PAWN):
							return 7;
						case (Kind.ROOK):
							return 3;
						case (Kind.KNIGHT):
							return 5;
						case (Kind.BISHOP):
							return 4;
						case (Kind.QUEEN):
							return 2;
						case (Kind.KING):
							return 1;
						default:
							return 1;
					}
				}
				
				public string getTerminalCharacter()
				{
					if (this.colour == Colour.BLACK)
					{
						switch (this.kind)
						{
							case (Kind.PAWN):
								return "♙";
							case (Kind.ROOK):
								return "♖";
							case (Kind.KNIGHT):
								return "♘";
							case (Kind.BISHOP):
								return "♗";
							case (Kind.QUEEN):
								return "♕";
							case (Kind.KING):
								return "♔";
							default:
								return " ";
						}
					}
					else
					{
						switch (this.kind)
						{
							case (Kind.PAWN):
								return "♟";
							case (Kind.ROOK):
								return "♜";
							case (Kind.KNIGHT):
								return "♞";
							case (Kind.BISHOP):
								return "♝";
							case (Kind.QUEEN):
								return "♛";
							case (Kind.KING):
								return "♚";
							default:
								return " ";
						}
					}
				}
			}
			
			public enum Kind
			{
				PAWN,
				ROOK,
				KNIGHT,
				BISHOP,
				QUEEN,
				KING
			}
			
			public enum Colour
			{
				BLACK,
				WHITE,
			}
		}
	}
}
