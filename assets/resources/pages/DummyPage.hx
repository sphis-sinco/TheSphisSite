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
				new PageEvent(new PageEventID(PageEventID.image, {
					general_position: new Position(0, 0),

					img_makeGraphic: true,
					img_graphicColor: FlxColor.BLACK,
					img_graphicDimensions: [FlxG.width, FlxG.height]
				}), 'backdrop'),
				new PageEvent(new PageEventID(PageEventID.url_text, {
					general_position: new Position(10, 10),

					text_content: "Hello world!",
					text_size: 32,
					text_color: FlxColor.WHITE,

					url_text_hover_color: FlxColor.BLUE,
					url_obj_pressed_callback: () ->
					{
						FlxG.switchState(() -> new Index());
					},
				}), 'hi'),
			];
		}
	}
}
