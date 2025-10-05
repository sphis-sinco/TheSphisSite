package states.site;

import flixel.FlxBasic;
import flixel.FlxG;
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

	override public function new(id:String)
	{
		super(id);

		#if sys
		Sys.println('\n---------------- Switched to Page: "$id" ----------------\n');
		#else
		trace('\n\n---------------- Switched to Page: "$id" ----------------\n');
		#end
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

			if (content.event.id == 'text' || content.event.id == 'url_text')
			{
				var newObject:FlxText = new FlxText(position.x, position.y);

				newObject.string_ID = content.id;
				newObject.text = content.event.params.text_content ?? "";
				newObject.size = content.event.params.text_size ?? 16;
				newObject.color = content.event.params.text_color ?? FlxColor.WHITE;

				if (content.event.id == 'url_text')
				{
					newObject.update_callback = () ->
					{
						newObject.color = (FlxG.mouse.overlaps(newObject) ? (getObjectContent(newObject.string_ID)
							.event.params.url_text_hover_color) : (getObjectContent(newObject.string_ID).event.params.text_color ?? FlxColor.WHITE));
						if (FlxG.mouse.justReleased && FlxG.mouse.overlaps(newObject))
						{
							if (content.event.params.url_obj_pressed_callback != null)
								content.event.params.url_obj_pressed_callback();
						}
					}

					trace('Parsed URL_Text Event: ' + content.id);
				}
				else
					trace('Parsed Text Event: ' + content.id);

				objects.add(newObject);
			}

			if (content.event.id == 'image')
			{
				var newObject:FlxSprite = new FlxSprite(position.x, position.y);

				newObject.string_ID = content.id;

				if (content.event.params.img_makeGraphic)
				{
					var dimensions = content.event.params.img_graphicDimensions ?? [32, 32];
					newObject.makeGraphic(dimensions[0], dimensions[1], content.event.params.img_graphicColor ?? FlxColor.RED);
				}
				else
				{
					newObject.loadGraphic(content.event.params.img_assetPath);
				}

				var scale = content.event.params.img_scale ?? new Position(1, 1);
				newObject.scale.set(scale.x, scale.y);

				trace('Parsed Image Event: ' + content.id);
				objects.add(newObject);
			}
		}
	}

	public function getObject(id:String):FlxBasic
	{
		var indexOfId = -1;

		var index = 0;
		for (content in pageContent)
		{
			if (content.id == id)
				indexOfId = index;

			index++;
		}

		return ((indexOfId >= 0) ? objects.members[indexOfId] : null);
	}
	public function getObjectContent(id:String):PageEvent
	{
		var indexOfId = -1;

		var index = 0;
		for (content in pageContent)
		{
			if (content.id == id)
				indexOfId = index;

			index++;
		}

		return ((indexOfId >= 0) ? pageContent[indexOfId] : new PageEvent(null, null));
	}

	override public function create()
	{
		super.create();

		if (objects == null)
			objects = new FlxTypedGroup<FlxBasic>();
		refresh();

		add(objects);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		for (object in objects)
		{
			if (object.update_callback != null)
				object.update_callback();
		}
	}
}
