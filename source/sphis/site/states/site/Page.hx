package sphis.site.states.site;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import sphis.site.utils.Position;

class Page extends ModuleState
{
	public var pageContent:Array<PageEvent> = [];

	public var addedObjectIDS:Array<String> = [];
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

	override public function create()
	{
		super.create();

		addedObjectIDS = [];
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

	override function destroy()
	{
		if (objects != null)
		{
			for (object in objects.members)
			{
				objects.members.remove(object);
				object.destroy();
			}
		}

		addedObjectIDS = [];
		pageContent = [];

		super.destroy();
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

			// trace('Found content event: "${content.event.id}" with id "${content.id}". Parsing...');

			switch (content.event.id.toLowerCase())
			{
				case 'text', 'url_text':
					parseText(content.id, position);

				case 'image', 'url_image':
					parseImage(content.id, position);

				// case 'checkbox':
				// 	parseCheckbox(content.id, position);

				default:
					trace('Content event missing a parse: ${content.event.id}');
			}
		}
	}

	public function parseText(contentID:String, position:Position)
	{
		var content = getObjectContent(contentID);

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
		}

		if (!addedObjectIDS.contains(content.id))
		{
			if (content.event.id == 'url_text')
				trace('Parsed URL_Text Event: ${content.id}');
			else
				trace('Parsed Text Event: ${content.id}');
			objects.add(newObject);
			addedObjectIDS.push(content.id);
		}
		else
		{
			if (content.event.id == 'url_text')
				trace('Did not add potential duplicate URL_Text Event: ${content.id}');
			else
				trace('Did not add potential duplicate Text Event: ${content.id}');
		}
	}

	public function parseImage(contentID:String, position:Position)
	{
		var content = getObjectContent(contentID);

		var newObject:FlxSprite = new FlxSprite(position.x, position.y);

		newObject.string_ID = content.id;

		var graphicColor = content.event.params.img_graphicColor ?? FlxColor.RED;

		if (content.event.params.img_makeGraphic)
		{
			var dimensions = content.event.params.img_graphicDimensions ?? [32, 32];
			newObject.makeGraphic(dimensions[0], dimensions[1], graphicColor);
		}
		else
		{
			newObject.loadGraphic(content.event.params.img_assetPath);
		}

		var scale = content.event.params.img_scale ?? new Position(1, 1);
		newObject.scale.set(scale.x, scale.y);

		if (content.event.id == 'url_image')
		{
			var hoverColor = content.event.params.url_image_graphic_hover_color ?? FlxColor.GREEN;

			newObject.update_callback = () ->
			{
				if (content.event.params.img_makeGraphic)
					newObject.color = (FlxG.mouse.overlaps(newObject) ? hoverColor : graphicColor);

				var hoverScale = content.event.params.url_image_hover_scale ?? new Position(1, 1);
				newObject.scale.set((FlxG.mouse.overlaps(newObject) ? hoverScale.x : scale.x), (FlxG.mouse.overlaps(newObject) ? hoverScale.y : scale.y));

				if (FlxG.mouse.justReleased && FlxG.mouse.overlaps(newObject))
				{
					if (content.event.params.url_obj_pressed_callback != null)
						content.event.params.url_obj_pressed_callback();
				}
			}
		}

		if (!addedObjectIDS.contains(content.id))
		{
			if (content.event.id == 'url_image')
				trace('Parsed URL_Image Event: ${content.id}');
			else
				trace('Parsed Image Event: ${content.id}');
			objects.add(newObject);
			addedObjectIDS.push(content.id);
		}
		else
		{
			if (content.event.id == 'url_image')
				trace('Did not add potential duplicate URL_Image Event: ${content.id}');
			else
				trace('Did not add potential duplicate Image Event: ${content.id}');
		}
	}
}
