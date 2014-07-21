package com.lolin.NS.app.view.Events
{
	import flash.events.Event;
	
	public class DeleteEvent extends Event
	{
		static public const DELETEEVENT:String = "deleteevent";
		public var data:Object;
		
		public function DeleteEvent(data:Object, type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data=data;
		}
	}
}