package sphis.site.states.site;

class Index extends Page
{
	public static var instance:Index;

	override public function new()
	{
		super('index');
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
