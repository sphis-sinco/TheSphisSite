package states;

class BlankState extends ModuleState
{
	public static var instance:BlankState = null;

	override public function new(id:String)
	{
		super(id);

		if (instance != null)
			instance = null;
		instance = this;
	}

	override public function create()
	{
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	override function destroy()
	{
		super.destroy();

		instance = null;
	}
}