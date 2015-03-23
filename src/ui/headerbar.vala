namespace knightmare
{
	namespace UI
	{
		public class HeaderBar : Gtk.HeaderBar
		{
			public Window mother;
			public Application root;
			
			public Gtk.Button move_button;
			
			public HeaderBar(Window mother)
			{
				this.mother = mother;
				this.root = this.mother.root;
				
				this.title = "Chess Engine";
				this.show_close_button = true;
				
				this.move_button = new Gtk.Button();
				this.move_button.set_label("Next Move");
				this.move_button.clicked.connect(this.moveClicked);
				this.add(this.move_button);
				
				this.show_all();
			}
			
			public void moveClicked()
			{
				this.mother.game.board.moveRandom();
			}
		}
	}
}
