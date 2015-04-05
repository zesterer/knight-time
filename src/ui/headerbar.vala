namespace knightmare
{
	namespace UI
	{
		public class HeaderBar : Gtk.HeaderBar
		{
			public Window mother;
			public Application root;
			
			public Gtk.Button move_button;
			
			public Gtk.Button config_button;
			public ConfigPopover config_popover;
			
			public HeaderBar(Window mother)
			{
				this.mother = mother;
				this.root = this.mother.root;
				
				this.title = "Chess Engine";
				this.resetTitle();
				this.mother.game.board.updated.connect(this.resetTitle);
				this.show_close_button = true;
				
				this.move_button = new Gtk.Button();
				this.move_button.set_label("Move");
				this.move_button.clicked.connect(this.moveClicked);
				this.add(this.move_button);
				
				this.config_button = new Gtk.Button.from_icon_name("preferences-system-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
				this.pack_end(this.config_button);
				
				this.config_popover = new ConfigPopover(this, this.config_button);
				this.config_button.clicked.connect(this.config_popover.toggleShow);
				
				this.show_all();
			}
			
			public void moveClicked()
			{
				this.mother.game.board.moveRandom();
			}
			
			public void resetTitle()
			{
				switch(this.mother.game.board.turn)
				{
					case (Core.Piece.Colour.WHITE):
						this.title = "White to play";
						break;
					case (Core.Piece.Colour.BLACK):
						this.title = "Black to play";
						break;
				}
			}
		}
	}
}
