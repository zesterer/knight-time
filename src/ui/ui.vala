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