package sphis.site;

import flixel.FlxG;
import lime.app.Application;

class Preferences
{
	public static var darkMode(get, set):Bool;

	static function set_darkMode(value:Bool):Bool
	{
		FlxG.save.data.darkMode = value;

		return get_darkMode();
	}

	static function get_darkMode():Bool
	{
		return FlxG.save.data.darkMode ?? false;
	}

	public static function initalizePreferences()
	{
		FlxG.save.bind('TheSphisSite', Application.current.meta.get('company'));

		FlxG.save.data.darkMode ??= false;
	}
}
