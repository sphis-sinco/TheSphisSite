package modding.modules;

import modding.events.StateEvent;

class ModuleEvent extends StateEvent
{
	public var module:Module;

	public function new(module:Module, state:String)
	{
		super(state);

		this.module = module;
	}
        
	override public function toString():String
		return 'ModuleEvent(module: $module, state: $state)';
}