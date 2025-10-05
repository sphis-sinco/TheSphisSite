package states.site;

import states.site.PageEventID;

class PageEvent
{
	public var event:PageEventID;
	public var id:String;

	public function new(event:PageEventID, id:String)
	{
		this.event = event;
		this.id = id;
	}
}
