package states;

import flixel.FlxG;
import flixel.FlxState;
import modding.PolymodHandler;
// import states.play.PlayState;

class InitState extends FlxState
{
	override function create()
	{
		super.create();

		PolymodHandler.forceReloadAssets();

		// FlxG.switchState(() -> new PlayState());
	}
}
