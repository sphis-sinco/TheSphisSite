package states.site;

import flixel.FlxBasic;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import utils.Position;

class Page extends ModuleState
{
	public var pageContent:Array<PageEvent> = [];

	public var objects:FlxTypedGroup<FlxBasic>;

	override function create()
	{
		super.create();

		if (objects == null)
			objects = new FlxTypedGroup<FlxBasic>();
		refresh();

		add(objects);

	}

	public function refresh()
	{

		if (objects == null)
			objects = new FlxTypedGroup<FlxBasic>();

		for (object in objects.members)
		{
			objects.members.remove(object);
			object.destroy();
		}

		for (content in pageContent)
		{
			var position = content.event.params.general_position ?? new Position(0, 0);

			trace('Found content event: "${content.event.id}" with id "${content.id}". Parsing...');

			if (content.event.id == 'text')
			{
				var newObject:FlxText = new FlxText(position.x, position.y);

				newObject.text = content.event.params.text_content ?? "";
				newObject.size = content.event.params.text_size ?? 16;
				newObject.color = content.event.params.text_color ?? FlxColor.BLACK;

				trace('Parsed Text Event: ' + content.id);
				objects.add(newObject);
			}

			if (content.event.id == 'image')
			{
				var newObject:FlxSprite = new FlxSprite(position.x, position.y);

				if (content.event.params.img_makeGraphic)
				{
					var dimensions = content.event.params.img_graphicDimensions ?? [32, 32];
					newObject.makeGraphic(dimensions[0], dimensions[1], content.event.params.img_graphicColor ?? FlxColor.RED);
				}
				else
				{
					newObject.loadGraphic(content.event.params.img_assetPath);
				}

				newObject.scale.set(content.event.params.img_scale.x, content.event.params.img_scale.y);

				trace('Parsed Image Event: ' + content.id);
				objects.add(newObject);
			}
		}
	}
}
