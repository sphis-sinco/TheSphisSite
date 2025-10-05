package source.sphis.site;

import haxe.macro.Compiler;
#if sys
import sys.io.File;
#end

class Prebuild
{
	static inline final BUILD_TIME_FILE:String = '.build_time';
	static var log:(String, Bool) -> Void;

	static function main()
	{
		log = function(s:String, format:Bool)
		{
			var s_formatted = '[PREBUILD] $s';

			#if sys
			Sys.println((format) ? s_formatted : s);
			#else
			trace((format) ? s_formatted : s);
			#end
		};

		log('-------------------- PREBUILD LOGS --------------------', false);

		#if sys
		log('System platform', true);
		#else
		log('Non-system platform', true);
		#end

		#if sys
		var start:Float = Sys.time();

		saveBuildTime();

		var end:Float = Sys.time();
		var duration:Float = end - start;
		#end

		#if debug
		log('Debug build', true);
		#else
		log('Non-debug build', true);
		#end

		#if watch
		log('Watch build', true);
		#else
		log('Non-watch build', true);
		#end

		#if watchassets
		log('Watch-assets build', true);
		#else
		log('Non-watch-assets build', true);
		#end

		log('------------------------ MACROS -----------------------', false);
	}

	static function saveBuildTime():Void
	{
		#if sys
		var fo:sys.io.FileOutput = File.write(BUILD_TIME_FILE);
		var now:Float = Sys.time();
		fo.writeDouble(now);
		fo.close();
		log('Saved build time file "$BUILD_TIME_FILE"', true);
		#else
		log('Couldn\'t save build time file "$BUILD_TIME_FILE"', true);
		#end
	}
}
