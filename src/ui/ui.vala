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
		}
	}
}

int main(string[] args)
{
	Gtk.init(ref args);
	
	knightmare.UI.Application application = new knightmare.UI.Application();
	application.start();
	
	return 0;
}
