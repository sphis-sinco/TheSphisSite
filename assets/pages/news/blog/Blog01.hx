import flixel.FlxG;
import sphis.site.modding.events.CreateEvent;
import sphis.site.modding.events.UpdateEvent;
import sphis.site.modding.modules.Module;
import sphis.site.modding.modules.ModuleHandler;
import sphis.site.states.site.BlankPage;
import sphis.site.states.site.PageEvent;
import sphis.site.utils.Position;

using StringTools;

class Blog1 extends Module
{
	override public function new()
	{
		super('blog1');
	}

	override function onCreate(event:CreateEvent)
	{
		super.onCreate(event);

		if (event.state != 'blog1')
			return;

		performedPostCreateFunctions = false;

		ModuleHandler.getModule('base-page-shit').reload();
		var back = ModuleHandler.getModule('base-page-shit').back(new Position(10, 130));

		back.event.url_obj_pressed_callback = () ->
		{
			FlxG.switchState(() -> new BlankPage('news'));
		};

		BlankPage.instance.pageContent = [
			ModuleHandler.getModule('base-page-shit').backdrop,
			ModuleHandler.getModule('base-page-shit').helloworld,
			ModuleHandler.getModule('base-page-shit').version,
			ModuleHandler.getModule('base-page-shit').splitter,
			back,
		];
	}

	public var performedPostCreateFunctions:Bool = false;

	override function onUpdate(event:UpdateEvent)
	{
		super.onUpdate(event);

		if (event.state != 'blog1')
			return;

		if (performedPostCreateFunctions)
			return;
		performedPostCreateFunctions = true;
		if (BlankPage.instance.getObject('hello-world') != null)
		{
			BlankPage.instance.getObject('hello-world').text += '\n(Blog #1)';
		}
		if (BlankPage.instance.getObject('version') != null)
		{
			BlankPage.instance.getObject('version').fieldWidth = FlxG.width;
			BlankPage.instance.getObject('version').alignment = 'right';
		}
	}
}
