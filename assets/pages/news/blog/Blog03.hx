import flixel.FlxG;
import flixel.util.FlxColor;
import sphis.site.Preferences;
import sphis.site.modding.events.CreateEvent;
import sphis.site.modding.events.UpdateEvent;
import sphis.site.modding.modules.Module;
import sphis.site.modding.modules.ModuleHandler;
import sphis.site.states.site.BlankPage;
import sphis.site.states.site.PageEvent;
import sphis.site.states.site.PageEventID;
import sphis.site.utils.Position;

using StringTools;

class Blog3 extends Module
{
	override public function new()
	{
		super('blog3');
	}

	override function onCreate(event:CreateEvent)
	{
		super.onCreate(event);

		if (event.state != 'blog3')
			return;

		performedPostCreateFunctions = false;

		ModuleHandler.getModule('base-page-shit').reload();
		var back = ModuleHandler.getModule('base-page-shit').back(new Position(10, 130));
		var second_splitter = ModuleHandler.getModule('base-page-shit').splitter(new Position(0, 175));

		back.event.params.url_obj_pressed_callback = () ->
		{
			FlxG.switchState(() -> new BlankPage('news'));
		};
		second_splitter.id = 'splitter_2';

		BlankPage.instance.pageContent = [
			ModuleHandler.getModule('base-page-shit').backdrop,
			ModuleHandler.getModule('base-page-shit').helloworld,
			ModuleHandler.getModule('base-page-shit').version,
			ModuleHandler.getModule('base-page-shit').splitter(),
			back,
			second_splitter,
			new PageEvent(new PageEventID(PageEventID.text, {
				general_position: new Position(10, 200),

				text_size: 48,
				text_color: (Preferences.darkMode) ? FlxColor.WHITE : FlxColor.BLACK,
				text_content: "Heya."
			}), 'greet'),
			new PageEvent(new PageEventID(PageEventID.text, {general_position: new Position(10, 275),

				text_size: 24,
				text_color: (Preferences.darkMode) ? FlxColor.WHITE : FlxColor.BLACK,
				text_content: "New blog post becuz the sites gettin' updates now because"
				+ "\nI remembered I wanted to make an interactive site."
				+ "\nSo yeah."
				+ "\nThere is now the Sphis Riryk on the Index page for just,"
				+ "\nsmth to mess with."
				+ "\nSo far only 3 \"poses\" that it has that you can get"
				+ "\n\nSo yeah."
				+ "\nThat's it. Adios."}), 'msg'),
		];
	}

	public var performedPostCreateFunctions:Bool = false;

	override function onUpdate(event:UpdateEvent)
	{
		super.onUpdate(event);

		if (event.state != 'blog3')
			return;

		if (performedPostCreateFunctions)
			return;
		performedPostCreateFunctions = true;
		if (BlankPage.instance.getObject('hello-world') != null)
		{
			BlankPage.instance.getObject('hello-world').text += '\n(Blog #3)';
		}
		if (BlankPage.instance.getObject('version') != null)
		{
			BlankPage.instance.getObject('version').fieldWidth = FlxG.width;
			BlankPage.instance.getObject('version').alignment = 'right';
		}
	}
}
