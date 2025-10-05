import flixel.FlxG;
import flixel.FlxObject;
import flixel.input.keyboard.FlxKey;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import sphis.site.Preferences;
import sphis.site.modding.cheats.FlxCameraFollowStyleCheat;
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

using StringTools;

class ProjectsPage extends Module
{
	override public function new()
	{
		super('projects-page');

		projects = [];
		var doBloat = false;

		var BLANK = '';
		var BLOAT = 'Bloat';

		var INDIE_GAME = 'Game';
		var FNF_MOD_PSYCH = 'FNF MOD (Psych)';
		var FNF_MOD_VSLICE = 'FNF MOD (V-Slice)';

		// addProject('INDIE GAMES (Itch.io): ', null);

		addProject('Strangle game', 'https://sphis.itch.io/strangle-game', INDIE_GAME);
		addProject('Viwu shots', 'https://sphis.itch.io/viwu-shots', INDIE_GAME);
		addProject('Personalities: HAXEN', 'https://sphis.itch.io/personalities-haxen', INDIE_GAME);
		addProject('Sinco and Portilizen', 'https://sphis.itch.io/sinco-and-portilizen', INDIE_GAME);
		addProject('Prankton', 'https://sphis.itch.io/prankton', INDIE_GAME);
		addProject('Creative', 'https://sphis.itch.io/creative', INDIE_GAME);
		addProject('Mechanical support', 'https://sphis.itch.io/mechanical-support', INDIE_GAME);
		addProject('Dreamland', 'https://sphis.itch.io/dreamland', INDIE_GAME);
		addProject('Personalities', 'https://sphis.itch.io/personalities', INDIE_GAME);
		addProject('EDFL', 'https://sphis.itch.io/earth-defence-force-launcher', INDIE_GAME);

		// addProject('INDIE GAMES (Newgrounds): ', null, BLANK);

		addProject('Click Progression', 'https://www.newgrounds.com/portal/view/987522', INDIE_GAME);

		// addProject('FNF MODS: ', null, BLANK);

		addProject('Itucow', 'https://gamebanana.com/mods/624384', FNF_MOD_VSLICE);
		addProject('Demunterm', 'https://gamebanana.com/mods/619640', FNF_MOD_VSLICE);
		addProject('Minimal UI', 'https://gamebanana.com/mods/619149', FNF_MOD_VSLICE);
		addProject('Intro Animations', 'https://gamebanana.com/mods/615897', FNF_MOD_VSLICE);
		addProject('Homie craft', 'https://gamebanana.com/mods/604621', FNF_MOD_PSYCH);
		addProject('EXMode', 'https://gamebanana.com/mods/587462', FNF_MOD_VSLICE);
		addProject('FNF vs Guy', 'https://gamebanana.com/mods/556236', FNF_MOD_PSYCH);
		addProject('FNF vs Guy (CONCEPT EDITION)', 'https://gamebanana.com/mods/492398', FNF_MOD_PSYCH);
		addProject('Pico Pico (Yellow Mix)', 'https://gamebanana.com/mods/555461', FNF_MOD_VSLICE);

		if (doBloat)
		{
			projects = [];
			var starti = 255;
			var i = starti;
			while (i > 0)
			{
				i--;
				addProject('Bloat ' + (starti - i), 'https://www.youtube.com/watch?v=dQw4w9WgXcQ', BLOAT);
				trace('Projects Bloated ' + (starti - i) + '/' + starti);
			}
		}

		addProject('', '', BLANK);
		addProject('', '', BLANK);
		addProject('', '', BLANK);
		addProject('', '', BLANK);
		addProject('', '', BLANK);
		addProject('', '', BLANK);
		addProject('', '', BLANK);
		addProject('', '', BLANK);
		addProject('', '', BLANK);
		addProject('', '', BLANK);
		addProject('', '', BLANK);
		addProject('', '', BLANK);
		addProject('', '', BLANK);
		addProject('', '', BLANK);
		addProject('', '', BLANK);
	}

	public var projects:Array<
		{
			name:String,
			url:String,
			title:String,
		}> = [];

	public function addProject(name:String, url:String, title:String)
	{
		if (name == '')
			return;

		projects.push({
			name: name,
			url: url,
			title: title,
		});
	}

	public var max_x:Float = 0;

	public var camFollow:FlxObject;

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

		var position:Position = new Position(10, 180);
		max_x = 0;

		for (project in projects)
		{
			var text_content = project.name + ((project.title != '' && project.title != null) ? ' (' + project.title + ')' : '');

			BlankPage.instance.pageContent.push(new PageEvent(new PageEventID(PageEventID.url_text, {
				general_position: position.clone(),

				text_content: text_content,
				text_size: 24,
				text_color: (Preferences.darkMode) ? FlxColor.WHITE : FlxColor.BLACK,

				url_obj_pressed_callback: () ->
				{
					if (project.url != null && project.url != '')
						FlxG.openURL(project.url);
				},
				url_text_hover_color: (project.url != null && project.url != '') ? FlxColor.LIME : (Preferences.darkMode) ? FlxColor.WHITE : FlxColor.BLACK
			}), 'project-' + project.name.toLowerCase().replace(' ', '_')));

			position.y += 50;

			if (position.y >= FlxG.height)
			{
				position.x += (new FlxText(0, 0, 0, text_content).width * 5);
				position.y = 130;
			}

			if (position.x > max_x)
			{
				trace('max_x transforming from ' + max_x + ' to ' + position.x);
				max_x = position.x;
			}
		}

		camFollow = new FlxObject(640, 360);
		BlankPage.instance.add(camFollow);

		FlxG.camera.follow(camFollow, FlxCameraFollowStyleCheat.LOCKON, .5);
	}

	public var performedPostCreateFunctions:Bool = false;

	override function onUpdate(event:UpdateEvent)
	{
		super.onUpdate(event);

		if (event.state != 'projects')
			return;

		if (max_x > 640)
		{
			if (FlxG.keys.anyPressed([FlxKey.A, FlxKey.LEFT]))
				camFollow.x -= 32;
			if (FlxG.keys.anyPressed([FlxKey.D, FlxKey.RIGHT]))
				camFollow.x += 32;

			if (camFollow.x < 640)
				camFollow.x = 640;
			if (camFollow.x >= 640 + max_x)
				camFollow.x = 640 + max_x;
		}

		if (performedPostCreateFunctions)
			return;

		performedPostCreateFunctions = true;

		if (BlankPage.instance.getObject('backdrop') != null)
			BlankPage.instance.getObject('backdrop').scrollFactor.set();
		if (BlankPage.instance.getObject('splitter') != null)
			BlankPage.instance.getObject('splitter').scrollFactor.set();

		if (BlankPage.instance.getObject('hello-world') != null)
		{
			BlankPage.instance.getObject('hello-world').scrollFactor.set();
			BlankPage.instance.getObject('hello-world').text += '\n(Projects Page)' + ((max_x > 640) ? ' (LEFT/RIGHT / A/D to scroll)' : '');
		}

		if (BlankPage.instance.getObject('version') != null)
		{
			BlankPage.instance.getObject('version').scrollFactor.set();
			BlankPage.instance.getObject('version').fieldWidth = FlxG.width;
			BlankPage.instance.getObject('version').alignment = 'right';
		}
	}
}
