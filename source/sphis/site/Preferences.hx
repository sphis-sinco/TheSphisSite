package sphis.site;

import flixel.FlxG;
import lime.app.Application;

class Preferences
{
	public static function initalizePreferences()
	{
		FlxG.save.bind('TheSphisSite', Application.current.meta.get('company'));
	}
}
