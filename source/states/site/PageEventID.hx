package states.site;

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