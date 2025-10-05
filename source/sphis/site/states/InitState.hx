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
		Preferences.initalizePreferences();

		FlxG.switchState(() -> new sphis.site.states.site.Index());
	}
}
