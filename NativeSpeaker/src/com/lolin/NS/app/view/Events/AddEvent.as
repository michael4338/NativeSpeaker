package com.lolin.NS.app.view.Events
{
	import flash.events.Event;
	
	public class AddEvent extends Event
	{
		static public const ADDEVENT:String = "addevent";
		public var data:Object;
		
		public function AddEvent(data:Object, type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data=data;
		}
	}
}