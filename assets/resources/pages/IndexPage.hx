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
				new PageEvent(new PageEventID(PageEventID.url_image, {
					general_position: new Position(640, 0),

					img_makeGraphic: true,
					img_graphicColor: FlxColor.WHITE,
					img_graphicDimensions: [640, FlxG.height],

					url_image_graphic_hover_cover: FlxColor.RED,
				}), 'backdrop'),
				new PageEvent(new PageEventID(PageEventID.url_text, {
					general_position: new Position(10, 10),

					text_content: "Hello world!",
					text_size: 32,
					text_color: FlxColor.WHITE,

					url_text_hover_color: FlxColor.BLUE,
					url_obj_pressed_callback: () ->
					{
						FlxG.switchState(() -> new BlankPage('dummy-page'));
					},
				}), 'hi'),
			];
		}
	}
}
