namespace knightmare
{
	namespace UI
	{
		public class Window : Gtk.Window
		{
			public Application mother;
			public Application root;
			
			public Core.Game game;
			
			public HeaderBar header_bar;
			public BoardArea board_area;
			
			public Window(Application mother)
			{
				this.mother = mother;
				this.root = this.mother.root;
				
				this.destroy.connect(this.mother.close);
				
				this.game = new Core.Game();
				game.board.setup();
				
				this.header_bar = new HeaderBar(this);
				this.set_titlebar(this.header_bar);
				
				this.board_area = new BoardArea(this);
				this.game.board.updated.connect(this.board_area.queue_draw);
				this.add(this.board_area);
				
				this.show_all();
			}
		}
	}
}
