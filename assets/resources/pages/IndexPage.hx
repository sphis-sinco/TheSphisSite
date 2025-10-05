import modding.events.CreateEvent;
import modding.modules.Module;
import states.site.Index;
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
				new PageEvent(new PageEventID('text', {
					general_position: new Position(10, 10),

					text_content: "Hello world!",
					text_size: 32,
				}), 'hi'),
			];
		}
	}
}
