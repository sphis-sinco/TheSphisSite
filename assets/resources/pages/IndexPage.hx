import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import modding.events.CreateEvent;
import modding.events.UpdateEvent;
import modding.modules.Module;
import states.site.BlankPage;
import states.site.Index;
import states.site.Page;
import states.site.PageEvent;
import states.site.PageEventID;
import utils.Position;

class IndexPage extends Module
{
	override public function new()
	{
		super('index-page');
	}

	override function onCreate(event:CreateEvent)
	{
		super.onCreate(event);

		if (event.state == 'index')
		{
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
				new PageEvent(new PageEventID(PageEventID.url_text, {
					general_position: new Position(10, 80),

					text_content: "News",
					text_size: 16,
					text_color: FlxColor.BLACK,

					url_obj_pressed_callback: () -> {},
					url_text_hover_color: FlxColor.LIME
				}), 'hello-world'),
			];
		}
	}
}
