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
import sphis.site.states.site.PageEvent;
import sphis.site.states.site.PageEventID;
import sphis.site.utils.Position;

using StringTools;

class NewsPage extends Module
{
	override public function new()
	{
		super('news-page');

		news = [];
		var doBloat = false;

		addNews('Blog #1 (10/5/2025)', 'blog1');

		if (doBloat)
		{
			news = [];
			var starti = 255;
			var i = starti;
			while (i > 0)
			{
				i--;
				addNews('Bloat ' + (starti - i), 'projects');
				trace('News Bloated ' + (starti - i) + '/' + starti);
			}
		}
	}

	public var news:Array<
		{
			name:String,
			page:String,
		}> = [];

	public function addNews(name:String, page:String)
	{
		if (name == '')
			return;

		news.push({
			name: name,
			page: page,
		});
	}

	public var max_x:Float = 0;

	public var camFollow:FlxObject;

	override function onCreate(event:CreateEvent)
	{
		super.onCreate(event);

		if (event.state != 'news')
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

		for (news in news)
		{
			var text_content = news.name;

			BlankPage.instance.pageContent.push(new PageEvent(new PageEventID(PageEventID.url_text, {
				general_position: position.clone(),

				text_content: text_content,
				text_size: 24,
				text_color: (Preferences.darkMode) ? FlxColor.WHITE : FlxColor.BLACK,

				url_obj_pressed_callback: () ->
				{
					FlxG.switchState(() -> new BlankPage(news.page));
				},
				url_text_hover_color: (news.page != null && news.page != '') ? FlxColor.LIME : (Preferences.darkMode) ? FlxColor.WHITE : FlxColor.BLACK
			}), 'news-' + news.name.toLowerCase().replace(' ', '_')));

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

		if (event.state != 'news')
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
			BlankPage.instance.getObject('hello-world').text += '\n(News Page)' + ((max_x > 640) ? ' (LEFT/RIGHT / A/D to scroll)' : '');
		}

		if (BlankPage.instance.getObject('version') != null)
		{
			BlankPage.instance.getObject('version').scrollFactor.set();
			BlankPage.instance.getObject('version').fieldWidth = FlxG.width;
			BlankPage.instance.getObject('version').alignment = 'right';
		}
	}
}
