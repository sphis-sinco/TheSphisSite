package sphis.site.modding.events;

import sphis.site.modding.modules.ModuleEvent;

class CreateEvent extends ModuleEvent
{
	override function toString():String
		return 'CreateEvent(module: $module, state: $state)';
}
