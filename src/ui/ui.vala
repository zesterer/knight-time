namespace knightmare
{
	namespace UI
	{
		public class Application : Gtk.Application
		{
			public Window window;
			public Application root;
			
			public Application()
			{
				this.root = this;
				this.window = new Window(this);
				
				this.loadSettings();
			}
			
			public void loadSettings()
			{
				NMLParser parser = new NMLParser();
				parser.objectAdded.connect(this.handleConfigObject);
				parser.parseFile("config.nml");
			}
			
			public void handleConfigObject(NMLObject object)
			{
				//It must be the 'config' object
				if (object.name != "config")
					return; //Do nothing
				
				//Handle the NML Object properly
				string[] properties = object.getPropertyList();
				
				foreach (string property in properties)
				{
					switch (property)
					{
						case ("cell-width"):
							stdout.printf("Switched board cell width to '" + object.getProperty("cell-width") + "'\n"); //Give verbose output about the change
							this.window.board_area.resetResolution(int.parse(object.getProperty("cell-width")));
							break;
						case ("tile-filename"):
							stdout.printf("Switched tile set to '" + object.getProperty("tile-filename") + "'\n"); //Give verbose output about the change
							this.window.board_area.setPieces(object.getProperty("tile-filename"));
							break;
						default:
							//Output an error since the option is not recognised
							stdout.printf("Unrecognised config option parsed\n");
							break;
					}
				}
			}
			
			public void start()
			{
				Gtk.main();
			}
			
			public void close()
			{
				Gtk.main_quit();
			}
		}
	}
}