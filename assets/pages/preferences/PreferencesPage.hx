import flixel.FlxG;
import flixel.util.FlxColor;
import sphis.site.Preferences;
import sphis.site.modding.events.CreateEvent;
import sphis.site.modding.events.UpdateEvent;
import sphis.site.modding.modules.Module;
import sphis.site.modding.modules.ModuleHandler;
import sphis.site.states.site.BlankPage;
import sphis.site.states.site.Index;
import sphis.site.states.site.PageEvent;
import sphis.site.states.site.PageEventID;
import sphis.site.utils.PathUtils;
import sphis.site.utils.Position;

class PreferencesPage extends Module
{
	override public function new()
	{
		super('preferences-page');
	}

	override function onCreate(event:CreateEvent)
	{
		super.onCreate(event);

		if (event.state != 'preferences')
			return;

		performedPostCreateFunctions = false;

		ModuleHandler.getModule('base-page-shit').reload();
		BlankPage.instance.pageContent = [
			ModuleHandler.getModule('base-page-shit').backdrop,
			ModuleHandler.getModule('base-page-shit').helloworld,
			ModuleHandler.getModule('base-page-shit').version,
			ModuleHandler.getModule('base-page-shit').splitter(),
			ModuleHandler.getModule('base-page-shit').back(new Position(10, 130)),

			new PageEvent(new PageEventID(PageEventID.url_text, {
				general_position: new Position(/* 32 */ 10, 130 + 50),

				text_content: "Clear Save",
				text_size: 24,
				text_color: (Preferences.darkMode) ? FlxColor.WHITE : FlxColor.BLACK,

				url_obj_pressed_callback: () ->
				{
					FlxG.save.erase();
					FlxG.switchState(() -> new BlankPage('preferences'));
				},
				url_text_hover_color: FlxColor.RED
			}), 'clear-save-text'),
			new PageEvent(new PageEventID(PageEventID.url_text, {
				general_position: new Position(10, 130 + (50 * 2)),

				text_content: "Dark mode: " + Preferences.darkMode,
				text_size: 24,
				text_color: (Preferences.darkMode) ? FlxColor.WHITE : FlxColor.BLACK,

				url_obj_pressed_callback: () ->
				{
					Preferences.darkMode = !Preferences.darkMode;
					FlxG.switchState(() -> new BlankPage('preferences'));
				},
				url_text_hover_color: FlxColor.LIME
			}), 'dark-mode-toggle'),
		];
	}

	public var performedPostCreateFunctions:Bool = false;

	override function onUpdate(event:UpdateEvent)
	{
		super.onUpdate(event);

		if (event.state != 'preferences' || performedPostCreateFunctions)
			return;

		performedPostCreateFunctions = true;

		if (BlankPage.instance.getObject('hello-world') != null)
		{
			BlankPage.instance.getObject('hello-world').text += '\n(Preferences Page)';
		}

		if (BlankPage.instance.getObject('version') != null)
		{
			BlankPage.instance.getObject('version').fieldWidth = FlxG.width;
			BlankPage.instance.getObject('version').alignment = 'right';
		}
	}
}
