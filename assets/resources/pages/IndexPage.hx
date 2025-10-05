import flixel.FlxG;
import flixel.util.FlxColor;
import sphis.site.modding.events.CreateEvent;
import sphis.site.modding.modules.Module;
import sphis.site.states.site.Index;
import sphis.site.states.site.PageEvent;
import sphis.site.states.site.PageEventID;
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
			new PageEvent(new PageEventID(PageEventID.image, {
				general_position: new Position(0, 0),

				img_makeGraphic: true,
				img_graphicColor: FlxColor.WHITE,
				img_graphicDimensions: [FlxG.width, FlxG.height],
			}), 'backdrop'),

			new PageEvent(new PageEventID(PageEventID.text, {
				general_position: new Position(10, 10),

				text_content: "Hello world!\nWelcome to The Sinco Site!",
				text_size: 32,
				text_color: FlxColor.BLACK,
			}), 'hello-world'),

			new PageEvent(new PageEventID(PageEventID.image, {
				general_position: new Position(0, 100),

				img_makeGraphic: true,
				img_graphicColor: FlxColor.GRAY,
				img_graphicDimensions: [FlxG.width, 16],
			}), 'splitter'),

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
		];
	}
}
