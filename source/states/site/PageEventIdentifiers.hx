package states.site;

import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class PageEventIdentifiers
{
	public static var TEXT:PageEventID = new PageEventID('text');
	public static var IMAGE:PageEventID = new PageEventID('image');
}

class PageEventID
{
	public var id:String;
	public var params:PageEventIDParams;

	public function new(id:String, params:PageEventIDParams)
	{
		this.id = id;
		this.params = params;
	}
}

typedef PageEventIDParams = {
	// general
	?general_position:FlxPoint,

	// text id
	?text_content:String,
	?text_size:Int,
	?text_color:FlxColor,

	// image id
	?img_assetPath:String,

	?img_makeGraphic:Bool,
	?img_graphicDimensions:Array<Int>,
	?img_graphicColor:FlxColor,

	?img_scale:FlxPoint,
}