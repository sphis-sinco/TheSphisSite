import flixel.FlxG;
import flixel.util.FlxColor;
import sphis.site.modding.events.CreateEvent;
import sphis.site.modding.events.UpdateEvent;
import sphis.site.modding.modules.Module;
import sphis.site.modding.modules.ModuleHandler;
import sphis.site.states.site.BlankPage;
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

		BlankPage.instance.pageContent = [
			ModuleHandler.getModule('base-page-shit').backdrop,
			ModuleHandler.getModule('base-page-shit').helloworld,
			ModuleHandler.getModule('base-page-shit').version,
			ModuleHandler.getModule('base-page-shit').splitter,
		];
	}

	public var performedPostCreateFunctions:Bool = false;

	override function onUpdate(event:UpdateEvent)
	{
		super.onUpdate(event);

		if (event.state != 'preferences' || performedPostCreateFunctions)
			return;

		performedPostCreateFunctions = true;
	}
}
