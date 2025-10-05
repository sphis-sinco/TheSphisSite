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
import sphis.site.utils.GitUtils;
import sphis.site.utils.Position;

class IndexPage extends Module
{
	override public function new()
	{
		super('index-page');
	}

	override function onCreate(event:CreateEvent)
	{
		super.onCreate(event);

		if (event.state != 'index')
			return;

		Index.instance.pageContent = [
			ModuleHandler.getModule('base-page-shit').backdrop,
			ModuleHandler.getModule('base-page-shit').helloworld,
			ModuleHandler.getModule('base-page-shit').version,
			ModuleHandler.getModule('base-page-shit').splitter,

			new PageEvent(new PageEventID(PageEventID.url_text, {
				general_position: new Position(10, 130),

				text_content: "News",
				text_size: 24,
				text_color: FlxColor.BLACK,

				url_obj_pressed_callback: () -> {},
				url_text_hover_color: FlxColor.LIME
			}), 'news-url'),

			new PageEvent(new PageEventID(PageEventID.url_text, {
				general_position: new Position(10, 180),

				text_content: "Projects",
				text_size: 24,
				text_color: FlxColor.BLACK,

				url_obj_pressed_callback: () -> {},
				url_text_hover_color: FlxColor.LIME
			}), 'projects-url'),

			new PageEvent(new PageEventID(PageEventID.url_text, {
				general_position: new Position(10, 230),

				text_content: "Preferences",
				text_size: 24,
				text_color: FlxColor.BLACK,

				url_obj_pressed_callback: () ->
				{
					FlxG.switchState(() -> new BlankPage('preferences'));
				},
				url_text_hover_color: FlxColor.LIME
			}), 'preferences-url'),
		];
	}

	public var performedPostCreateFunctions:Bool = false;

	override function onUpdate(event:UpdateEvent)
	{
		super.onUpdate(event);

		if (event.state != 'index' || performedPostCreateFunctions)
			return;

		performedPostCreateFunctions = true;

		if (Index.instance.getObject('hello-world') != null)
		{
			Index.instance.getObject('hello-world').text += '\n(Home Page)';
		}

		if (Index.instance.getObject('version') != null)
		{
			Index.instance.getObject('version').fieldWidth = FlxG.width;
			Index.instance.getObject('version').alignment = 'right';
		}
	}
}
