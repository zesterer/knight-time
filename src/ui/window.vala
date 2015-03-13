namespace knightmare
{
	namespace UI
	{
		public class Window : Gtk.Window
		{
			public Application mother;
			public Application root;
			
			public Gtk.Button test_button;
			
			public Window(Application mother)
			{
				this.mother = mother;
				this.root = this.mother.root;
				
				this.test_button = new Gtk.Button();
				this.test_button.set_label("Hello, World!");
				
				this.show_all();
			}
		}
	}
}
