package states.site;

class BlankPage extends Page
{
	public static var instance:BlankPage;

	override public function new(id:String)
	{
		super(id);
		
		if (instance != null)
			instance = null;
		instance = this;
	}
	override function create()
	{
		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
