package sphis.site.utils;

import lime.utils.Assets;
#if sys
import sys.FileSystem;
import sys.io.File;
#end

class PathUtils
{
	public static function getAssetPath(path:String):String
		return 'assets/$path';

	public static function getImage(path:String):String
		return 'assets/$path.png';

	public static function saveContent(path:String, content:String)
	{
		#if sys
		File.saveContent(path, content);
		#end
	}

	public static function pathExists(id:String):Bool
	{
		#if sys
		return FileSystem.exists(id);
		#else
		return Assets.exists(id);
		#end
	}

	public static function getText(id:String):String
	{
		#if sys
		return File.getContent(id);
		#else
		return Assets.getText(id);
		#end
	}
}
