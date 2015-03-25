namespace knightmare
{
	namespace UI
	{
		public class ActionBar : Gtk.ActionBar
		{
			public Window mother;
			public Application root;
			
      public Gtk.Button new_game_button;
			public Gtk.Entry command_entry;
			
			public ActionBar(Window mother)
			{
				this.mother = mother;
				this.root = this.mother.root;
				
				this.set_valign(Gtk.Align.END);
				
        this.new_game_button = new Gtk.Button();
        this.new_game_button.clicked.connect(this.newGameButtonClicked);
        this.new_game_button.set_label("New Game");
        this.pack_start(this.new_game_button);
        
				this.command_entry = new Gtk.Entry();
				this.command_entry.width_request = 250;
				this.command_entry.activate.connect(this.commandEntryActivated);
				this.set_center_widget(this.command_entry);
			}
      
      public void newGameButtonClicked()
      {
        this.mother.game.board.setup();
        this.mother.board_area.queue_draw();
      }
			
			public void commandEntryActivated()
			{
				stdout.printf("Recieved command '" + this.command_entry.get_text() + "'\n");
				this.command_entry.set_text("");
			}
		}
	}
}