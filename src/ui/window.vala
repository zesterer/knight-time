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
			public Gtk.Box main_box;
			public BoardArea board_area;
			public ActionBar action_bar;
			
			public Window(Application mother)
			{
				this.mother = mother;
				this.root = this.mother.root;
				
				this.destroy.connect(this.mother.close);
				
				this.game = new Core.Game();
				game.board.setup();
				
				this.header_bar = new HeaderBar(this);
				this.set_titlebar(this.header_bar);
				
				this.main_box = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
				this.add(this.main_box);
				
				this.board_area = new BoardArea(this);
				this.game.board.updated.connect(this.board_area.queue_draw);
				this.main_box.add(this.board_area);
				
				this.action_bar = new ActionBar(this);
				this.main_box.pack_end(this.action_bar);
				
				this.show_all();
			}
		}
	}
}
