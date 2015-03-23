namespace knightmare
{
	namespace UI
	{
		public class BoardArea : Gtk.DrawingArea
		{
			public Window mother;
			public Application root;
			
			public double cell_width;
			public double board_scale;
			
			Cairo.ImageSurface piece_surface;
			
			public BoardArea(Window mother)
			{
				this.mother = mother;
				this.root = this.mother.root;
				
				this.draw.connect(this.display);
				
				//Arbitary for now
				this.cell_width = 64;
				//64 is the base size
				this.board_scale = this.cell_width / 64;
				
				//Keep the board in the centre
				this.set_halign(Gtk.Align.CENTER);
				this.set_valign(Gtk.Align.CENTER);
				
				this.width_request = (int)this.cell_width * 8;
				this.height_request = (int)this.cell_width * 8;
				
				this.piece_surface = new Cairo.ImageSurface.from_png("resources/pieces.png");
			}
		
			public bool display(Cairo.Context context)
			{
				//Not needed yet
				//int width = this.get_allocated_width();
				//int height = this.get_allocated_height();
			
				this.drawBoard(context);
				
				this.drawPieces(context);
			
				return true;
			}
			
			public void drawBoard(Cairo.Context context)
			{
				for (int pos = 0; pos < 32; pos ++)
				{
					int add = 0;
					
					if ((pos / 4) % 2 == 0)
						add = (int)this.cell_width;
					
					context.rectangle((pos % 4) * this.cell_width * 2 + add, (pos / 4) * this.cell_width, this.cell_width, this.cell_width);
				}
			
				weak Gtk.StyleContext style_context = this.get_style_context();
				Gdk.RGBA colour = style_context.get_color(0);
				Gdk.cairo_set_source_rgba(context, colour);
				context.fill();
			}
			
			public void drawPieces(Cairo.Context context)
			{
				for (int8 x = 0; x < 8; x ++)
				{
					for (int8 y = 0; y < 8; y ++)
					{
						Core.Piece.Piece? piece = Core.Piece.kind[this.mother.game.board.data[x, y]];
						if (piece != null)
						{
							this.drawPiece(context, piece.kind, piece.colour, x, y);
						}
					}
				}
			}
			
			public void drawPiece(Cairo.Context context, Core.Piece.Kind kind, Core.Piece.Colour colour, int x, int y)
			{
				int colour_modifier = 0;
				if (colour == Core.Piece.Colour.WHITE)
					colour_modifier = 128; //Push the coordinates up
				
				int[2] pos;
				switch(kind)
				{
					case (Core.Piece.Kind.PAWN):
						pos = {128, 64};
						break;
					case (Core.Piece.Kind.ROOK):
						pos = {128, 0};
						break;
					case (Core.Piece.Kind.KNIGHT):
						pos = {64, 0};
						break;
					case (Core.Piece.Kind.BISHOP):
						pos = {64, 64};
						break;
					case (Core.Piece.Kind.QUEEN):
						pos = {0, 64};
						break;
					case (Core.Piece.Kind.KING):
						pos = {0, 0};
						break;
					default:
						pos = {0, 0};
						break;
				}
				//Draw the piece
				Cairo.Surface piece = new Cairo.Surface.for_rectangle(this.piece_surface, pos[0], pos[1] + colour_modifier, 64, 64);
				
				context.scale(this.board_scale, this.board_scale);
				context.set_source_surface(piece, x * 64, y * 64);
				context.scale(1.0 / this.board_scale, 1.0 / this.board_scale);
				context.paint();
			}
		}
	}
}