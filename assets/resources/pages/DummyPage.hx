import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import sphis.site.modding.events.CreateEvent;
import sphis.site.modding.events.UpdateEvent;
import sphis.site.modding.modules.Module;
import sphis.site.states.site.BlankPage;
import sphis.site.states.site.Index;
import sphis.site.states.site.Page;
import sphis.site.states.site.PageEvent;
import sphis.site.states.site.PageEventID;
import sphis.site.utils.Position;

class DummyPage extends Module
{
	override public function new()
	{
		super('dummy-page');
	}

	override function onCreate(event:CreateEvent)
	{
		super.onCreate(event);

		if (event.state == 'dummy-page')
		{
			BlankPage.instance.pageContent = [
				new PageEvent(new PageEventID(PageEventID.url_image, {
					general_position: new Position(640, 0),

					img_makeGraphic: true,
					img_graphicColor: FlxColor.WHITE,
					img_graphicDimensions: [640, FlxG.height],

					url_image_graphic_hover_color: FlxColor.BLUE,
				}), 'backdrop'),
				new PageEvent(new PageEventID(PageEventID.url_text, {
					general_position: new Position(10, 10),

					text_content: "Hello world!",
					text_size: 32,
					text_color: FlxColor.BLUE,

					url_text_hover_color: FlxColor.WHITE,
					url_obj_pressed_callback: () ->
					{
						FlxG.switchState(() -> new Index());
					},
				}), 'hi'),
			];
		}
	}
}
