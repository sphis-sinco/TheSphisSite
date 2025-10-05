package states.site;

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
}
