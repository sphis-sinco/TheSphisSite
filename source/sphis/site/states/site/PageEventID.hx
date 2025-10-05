package sphis.site.states.site;

class PageEventID
{
	public static var url_text:String = 'url_text';
	public static var text:String = 'text';

	public static var url_image:String = 'url_image';
	public static var image:String = 'image';

	public var id:String;
	public var params:PageEventIDParams;

	public function new(id:String, params:PageEventIDParams)
	{
		this.id = id;
		this.params = params;
	}
}
