public class DynamicList<G> : GLib.Object
{
	//The internal list. 'G' is the type that the list accepts (user-defined)
	private List<G> _list = new List<G>();
	
	//Add an item to the list
	public G add(G data)
	{
		this._list.append(data);
		
		return data;
	}
	
	//Remove a specific index of the list.
	public void remove_at(int index)
	{
		unowned List<G> todelete = this._list.nth(index);
		this._list.delete_link(todelete);
	}
	
	//Remove a specific index of the list.
	public void remove(G data)
	{
		this._list.remove(data);
	}
	
	//Find the object at index like: G object = list[x];
	public new G get(int index)
	{
		return this._list.nth_data(index);
	}
	
	//Same as above, except to set things like: list[x] = object;
	public new void set(int index, G data)
	{
		this._list.insert(data, index);
		this.remove_at(index + 1);
	}
	
	//Find the number of items in the list
	public int size()
	{
		return (int)this._list.length();
	}
	
	//Find out whether the list contains a specific object. Better than looping
	public bool contains(G data)
	{
		for (int count = 0; count < this._list.length(); count ++)
		{
			if (this._list.nth_data(count) == data)
				return true;
		}
		
		return false;
	}
	
	//Find the list's length. Same as DynamicList.size(), but used for more.
	public int length
	{
		get
		{return (int)this._list.length();}
	}
}
