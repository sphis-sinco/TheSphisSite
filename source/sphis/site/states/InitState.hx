package sphis.site.states;

import flixel.FlxG;
import flixel.FlxState;
import sphis.site.modding.PolymodHandler;

class InitState extends FlxState
{
	override function create()
	{
		super.create();

		Preferences.initalizePreferences();
		PolymodHandler.forceReloadAssets();

		FlxG.switchState(() -> new sphis.site.states.site.Index());
	}
}
