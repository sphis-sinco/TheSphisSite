package modding;

import flixel.FlxG;
import modding.events.*;
import modding.events.FocusEvent;
import modding.modules.*;
import polymod.Polymod;
import polymod.format.ParseRules;
import polymod.fs.ZipFileSystem;
import states.*;
import utils.StateUtils;
#if sys
import sys.FileSystem;
#end

class PolymodHandler
{
	// Use SysZipFileSystem on native and MemoryZipFilesystem on web.
	public static var modFileSystem:Null<ZipFileSystem> = null;

	public static function scriptShit()
	{
		var focusGained = function() ModuleHandler.callEvent(module ->
		{
			module.onFocusGained(new FocusEvent(FocusEventType.GAINED));
		});
		var focusLost = function() ModuleHandler.callEvent(module ->
		{
			module.onFocusGained(new FocusEvent(FocusEventType.GAINED));
		});
		var preStateSwitch = function() ModuleHandler.callEvent(module ->
		{
			module.onStateSwitchPre(new StateSwitchEvent(StateUtils.getCurrentState()));
		});
		var postStateSwitch = function() ModuleHandler.callEvent(module ->
		{
			module.onStateSwitchPost(new StateSwitchEvent(StateUtils.getCurrentState()));
		});

		if (!FlxG.signals.focusGained.has(() -> focusGained))
			FlxG.signals.focusGained.add(() -> focusGained);
		if (!FlxG.signals.focusLost.has(() -> focusLost))
			FlxG.signals.focusLost.add(() -> focusLost);
		if (!FlxG.signals.preStateSwitch.has(() -> preStateSwitch))
			FlxG.signals.preStateSwitch.add(() -> preStateSwitch);
		if (!FlxG.signals.postStateSwitch.has(() -> postStateSwitch))
			FlxG.signals.postStateSwitch.add(() -> postStateSwitch);

		addImports();
	}

	public static function addImports()
	{
		Polymod.addDefaultImport(BlankState);
		Polymod.addDefaultImport(ModuleState);
	}

	public static function buildParseRules():polymod.format.ParseRules
	{
		var output:polymod.format.ParseRules = polymod.format.ParseRules.getDefault();
		// Ensure TXT files have merge support.
		output.addType('txt', TextFileFormat.LINES);
		// Ensure script files have merge support.
		output.addType('hscript', TextFileFormat.PLAINTEXT);
		output.addType('hxs', TextFileFormat.PLAINTEXT);
		output.addType('hxc', TextFileFormat.PLAINTEXT);
		output.addType('hx', TextFileFormat.PLAINTEXT);

		// You can specify the format of a specific file, with file extension.
		// output.addFile("data/introText.txt", TextFileFormat.LINES)
		return output;
	}

	public static function buildIgnoreList():Array<String>
	{
		var result = Polymod.getDefaultIgnoreList();

		result.push('.git');
		result.push('.gitignore');
		result.push('.gitattributes');
		result.push('README.md');

		result.push('.haxelib');

		return result;
	}

	public static function loadMods(dirs:Array<String>)
	{
		Polymod.init({
			modRoot: 'mods/',
			dirs: dirs,
			errorCallback: onError,
			ignoredFiles: buildIgnoreList(),
			useScriptedClasses: true,
			loadScriptsAsync: #if html5 true #else false #end,
			framework: OPENFL,
			parseRules: buildParseRules(),
			customFilesystem: modFileSystem,
		});
	}

	public static function onError(error:PolymodError)
	{
		trace('[${error.severity}] (${Std.string(error.code).toUpperCase()}): ${error.message}');
	}

	public static function buildFileSystem():polymod.fs.ZipFileSystem
	{
		polymod.Polymod.onError = onError;
		return new ZipFileSystem({
			modRoot: 'mods/',
			autoScan: true
		});
	}

	public static function getAllMods():Array<ModMetadata>
	{
		trace('Scanning the mods folder...');

		var modMetadata:Array<ModMetadata> = Polymod.scan({
			modRoot: 'mods/',
			// apiVersionRule: API_VERSION_RULE,
			fileSystem: modFileSystem,
			errorCallback: onError
		});
		trace('Found ${modMetadata.length} mods when scanning.');
		return modMetadata;
	}

	public static function getAllModIds():Array<String>
	{
		var modIds:Array<String> = [for (i in getAllMods()) i.id];
		return modIds;
	}

	public static function forceReloadAssets():Void
	{
		if (modFileSystem == null)
			modFileSystem = buildFileSystem();

		// Forcibly clear scripts so that scripts can be edited.
		ModuleHandler.destroyModules();
		Polymod.clearScripts();

		scriptShit();

		loadMods(getAllModIds());
		ModuleHandler.loadModules();

		if (FlxG.state != null)
			FlxG.resetState();
	}
}
