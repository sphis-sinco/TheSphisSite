package states.site;

class PageEvent
{
	public var eventId:PageEventID;
	public var id:String;

	public function new(eventId:PageEventID, id:String)
	{
		this.id = id;
	}
}
