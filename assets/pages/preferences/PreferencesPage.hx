import flixel.FlxG;
import flixel.util.FlxColor;
import sphis.site.modding.events.CreateEvent;
import sphis.site.modding.events.UpdateEvent;
import sphis.site.modding.modules.Module;
import sphis.site.modding.modules.ModuleHandler;
import sphis.site.states.site.BlankPage;
import sphis.site.states.site.Index;
import sphis.site.states.site.PageEvent;
import sphis.site.states.site.PageEventID;
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

		BlankPage.instance.pageContent = [
			ModuleHandler.getModule('base-page-shit').backdrop,
			ModuleHandler.getModule('base-page-shit').helloworld,
			ModuleHandler.getModule('base-page-shit').version,
			ModuleHandler.getModule('base-page-shit').splitter,

			new PageEvent(new PageEventID(PageEventID.url_text, {
				general_position: new Position(10, 130),

				text_content: "Back",
				text_size: 24,
				text_color: FlxColor.BLACK,

				url_obj_pressed_callback: () ->
				{
					FlxG.switchState(() -> new Index());
				},
				url_text_hover_color: FlxColor.LIME
			}), 'back-url'),
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
