package states.site;

import flixel.FlxBasic;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class Page extends ModuleState
{
	public var pageContent:Array<PageEvent> = [];

	public var objects:FlxTypedGroup<FlxBasic>;

	override function create()
	{
		super.create();

		refresh();
	}

	public function refresh()
	{
		for (object in objects)
		{
			objects.members.remove(object);
			object.destroy();
		}

		for (content in pageContent)
		{
			var position = content.event.params.general_position ?? new FlxPoint();

			if (content.event.id == 'text')
			{
				var newObject:FlxText = new FlxText(position.x, position.y);

				newnewObject.text = content.event.params.text_content ?? "";
				newnewObject.size = content.event.params.text_size ?? 16;
				newnewObject.color = content.event.params.text_color ?? FlxColor.BLACK;

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

				newnewObject.scale.set(content.event.params.img_scale.x, content.event.params.img_scale.y);

				objects.add(newObject);
			}
		}
	}
}
