namespace knightmare
{
	namespace Core
	{
		public class Game : Object
		{
			public Board board;
			
			public Game()
			{
				this.board = new Board();
			}
		}
	}
}
