package states.site;

import flixel.util.FlxColor;
import utils.Position;

typedef PageEventIDParams =
{
	// general
	?general_position:Position,

	// url_ id's
	?url_obj_pressed_callback:Void->Void,

	// url_text id
	?url_text_hover_color:FlxColor,

	// text id
	?text_content:String,
	?text_size:Int,
	?text_color:FlxColor,

	// image id
	?img_assetPath:String,

	?img_makeGraphic:Bool,
	?img_graphicDimensions:Array<Int>,
	?img_graphicColor:FlxColor,

	?img_scale:Position,

	// url_image id
	?url_image_graphic_hover_cover:FlxColor,
	?url_image_hover_scale:Position,
}
