package sphis.site.modding.modules;

import flixel.util.FlxDestroyUtil.IFlxDestroyable;
import sphis.site.modding.events.CreateEvent;
import sphis.site.modding.events.FocusEvent;
import sphis.site.modding.events.StateSwitchEvent;
import sphis.site.modding.events.UpdateEvent;

class Module implements IFlxDestroyable
{
	public var id:String;

	public function new(id:String)
	{
		this.id = id;
	}

	public function toString():String
		return 'Module(id: $id)';

	// the events

	public function onInitalizePreferences(event:Dynamic) {}

	public function onCreate(event:CreateEvent) {}

	public function onUpdate(event:UpdateEvent) {}

	public function onStateSwitchPre(event:StateSwitchEvent) {}

	public function onStateSwitchPost(event:StateSwitchEvent) {}

	public function onFocusGained(event:FocusEvent) {}

	public function onFocusLost(event:FocusEvent) {}

	public function destroy() {}
}
