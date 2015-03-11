namespace knightmare
{
	namespace Core
	{
		public class Game : Object
		{
			public Board current_board;
			
			public Game()
			{
				this.current_board = new Board();
			}
		}
	}
}
