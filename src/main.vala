namespace knightmare
{
	int main(string[] args)
	{
		Gtk.init(ref args);
	
		//Set the core engine up
		Core.Piece.setup();
	
		UI.Application application = new UI.Application();
		application.start();
	
		return 0;
	}
}