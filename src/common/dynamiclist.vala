//This class here acts as a wrapper around GLib's built-in list type.
//I didn't like the GLib.List API, so I built this wrapper to abstract it
//behind a new interface that feels nicer to use when coding. It also makes
//things a lot easier.
//By the way, GLib is Vala's standard library.

public class DynamicList<G> : GLib.Object
{
	//The internal list. 'G' is the type that the list accepts (user-defined)
	private List<G> _list = new List<G>();
	
	//Add an item to the list
	public void add(G data)
	{
		this._list.append(data);
	}
	
	public void addList(DynamicList<G> list)
	{
		for (int count = 0; count < list.length; count ++)
		{
			this.add(list[0]);
		}
	}
	
	//And an array of values to the list
	public void addArray(G[] data)
	{
		for (int count = 0; count < data.length; count ++)
		{
			this.add(data[count]);
		}
	}
	
	public new G[] getArray()
	{
		G[] array = new G[this._list.length()];
		for (int count = 0; count < this._list.length(); count ++)
		{
			array[count] = this[count];
		}
		
		return array;
	}
	
	//Remove a specific item from the list.
	public void remove(G data)
	{
		this._list.remove(data);
	}
	
	//Remove a specific index of the list.
	public void remove_at(int index)
	{
		unowned List<G> todelete = this._list.nth(index % this.length);
		this._list.delete_link(todelete);
	}
	
	//Find the object at index like: G object = list[x];
	public new G get(int index)
	{
		return this._list.nth_data(index % this.length);
	}
	
	//Same as above, except to set things like: list[x] = object;
	public new void set(int index, G data)
	{
		this._list.insert(data, index % this.length);
		this.remove_at((index % this.length) + 1);
	}
	
	//Find the number of items in the list
	public int size
	{
		get
		{
			return (int)this._list.length();
		}
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
