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

class ProjectsPage extends Module
{
	override public function new()
	{
		super('projects-page');
	}

	override function onCreate(event:CreateEvent)
	{
		super.onCreate(event);

		if (event.state != 'projects')
			return;

		performedPostCreateFunctions = false;

		ModuleHandler.getModule('base-page-shit').reload();
		BlankPage.instance.pageContent = [
			ModuleHandler.getModule('base-page-shit').backdrop,
			ModuleHandler.getModule('base-page-shit').helloworld,
			ModuleHandler.getModule('base-page-shit').version,
			ModuleHandler.getModule('base-page-shit').splitter,
			ModuleHandler.getModule('base-page-shit').back(new Position(10, 130)),
		];
	}

	public var performedPostCreateFunctions:Bool = false;

	override function onUpdate(event:UpdateEvent)
	{
		super.onUpdate(event);

		if (event.state != 'projects' || performedPostCreateFunctions)
			return;

		performedPostCreateFunctions = true;

		if (BlankPage.instance.getObject('hello-world') != null)
		{
			BlankPage.instance.getObject('hello-world').text += '\n(Projects Page)';
		}

		if (BlankPage.instance.getObject('version') != null)
		{
			BlankPage.instance.getObject('version').fieldWidth = FlxG.width;
			BlankPage.instance.getObject('version').alignment = 'right';
		}
	}
}
