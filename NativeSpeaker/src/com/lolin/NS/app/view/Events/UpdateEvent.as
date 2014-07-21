package com.lolin.NS.app.view.Events
{
	import flash.events.Event;
	
	public class UpdateEvent extends Event
	{
		static public const UPDATEEVENT:String = "updateevent";
		public var data:Object;
		
		public function UpdateEvent(data:Object, type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data=data;
		}
	}
}