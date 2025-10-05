package sphis.site.states;

import flixel.FlxG;
import flixel.FlxState;
import sphis.site.modding.PolymodHandler;

class InitState extends FlxState
{
	override function create()
	{
		super.create();

		PolymodHandler.forceReloadAssets();

		FlxG.switchState(() -> new states.site.Index());
	}
}
