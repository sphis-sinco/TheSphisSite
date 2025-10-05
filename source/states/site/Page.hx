package states.site;

import flixel.FlxBasic;

class Page extends ModuleState
{
	public var pageContent:Array<PageEvent> = [];

	public var objects:Array<FlxBasic>;

	override function create()
	{
		super.create();

		refresh();
	}

	public function refresh()
	{
                for (object in objects)
                        object.destroy();
		objects = [];

		for (content in pageContent) {}
	}
}
