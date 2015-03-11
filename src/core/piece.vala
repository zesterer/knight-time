namespace knightmare
{
	namespace Core
	{
		namespace Piece
		{
			public Piece?[] pieces;
			
			public void setup()
			{
				pieces = {
					null,
					new Piece(Kind.PAWN, Colour.BLACK, 1, 0x01, "♟"),
					new Piece(Kind.ROOK, Colour.BLACK, 6, 0x02, "♜"),
					new Piece(Kind.KNIGHT, Colour.BLACK, 3, 0x03, "♞"),
					new Piece(Kind.BISHOP, Colour.BLACK, 3, 0x04, "♝"),
					new Piece(Kind.QUEEN, Colour.BLACK, 9, 0x05, "♛"),
					new Piece(Kind.KING, Colour.BLACK, 10000, 0x06, "♚"),
					
					new Piece(Kind.PAWN, Colour.WHITE, 1, 0x07, "♙"),
					new Piece(Kind.ROOK, Colour.WHITE, 6, 0x08, "♖"),
					new Piece(Kind.KNIGHT, Colour.WHITE, 3, 0x09, "♘"),
					new Piece(Kind.BISHOP, Colour.WHITE, 3, 0x0A, "♗"),
					new Piece(Kind.QUEEN, Colour.WHITE, 9, 0x0B, "♕"),
					new Piece(Kind.KING, Colour.WHITE, 10000, 0x0C, "♔")
					}; 
			}
			
			public class Piece : Object
			{
				public Kind kind;
				public Colour colour;
				public int points;
				public int id;
				public string character;
				
				public Piece(Kind kind, Colour colour, int points, int8 id, string character)
				{
					this.kind = kind;
					this.colour = colour;
					this.points = points;
					this.id = id;
					this.character = character;
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
				NONE
			}
		}
	}
}
