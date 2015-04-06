namespace knightmare
{
	namespace UI
	{
		public class ConfigPopover : Gtk.Popover
		{
			public HeaderBar mother;
			
			public Gtk.Box contents;
			
			public Gtk.Box spin_box;
			public Gtk.SpinButton spin_button;
			public Gtk.Box tileset_box;
			public Gtk.FileChooserButton tileset_button;
			public Gtk.FileFilter tileset_filter;
			
			public ConfigPopover(HeaderBar mother, Gtk.Widget relative_to)
			{
				this.mother = mother;
				this.set_relative_to(relative_to);
				
				this.contents = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
				this.add(this.contents);
				
				this.spin_box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 8);
				this.spin_box.add(new Gtk.Label("Board cell size"));
				this.contents.add(this.spin_box);
				
				this.spin_button = new Gtk.SpinButton(new Gtk.Adjustment(48.0, 8.0, 128.5, 1.0, 16.0, 1.0), 1.0, 0);
				this.spin_button.value_changed.connect(this.spinButtonValueChanged);
				this.spin_box.add(this.spin_button);
				
				this.tileset_box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 8);
				this.tileset_box.add(new Gtk.Label("Tileset image"));
				this.contents.add(this.tileset_box);
				
				this.tileset_filter = new Gtk.FileFilter();
				this.tileset_filter.set_filter_name("Chess Tilesets");
				this.tileset_filter.add_pattern("*.png");
				
				this.tileset_button = new Gtk.FileChooserButton("Select the render tileset", Gtk.FileChooserAction.OPEN);
				this.tileset_button.add_filter(this.tileset_filter);
				this.tileset_button.file_set.connect(this.tilesetFileSet);
				this.tileset_box.add(this.tileset_button);
				
				this.get_child().show_all();
			}
			
			public void toggleShow()
			{
				this.visible = !this.visible;
			}
			
			public void spinButtonValueChanged()
			{
				this.mother.mother.board_area.resetResolution((int)this.spin_button.get_value());
			}
			
			public void tilesetFileSet()
			{
				this.mother.mother.board_area.setPieces(this.tileset_button.get_file().get_path());
			}
		}
	}
}
