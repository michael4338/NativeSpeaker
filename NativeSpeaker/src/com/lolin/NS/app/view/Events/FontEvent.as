package com.lolin.NS.app.view.Events
{
	import flash.events.Event;
	
	public class FontEvent extends Event
	{
		static public const FONTEVENT:String = "fontevent";
		public var _font:String = null;
		
		public function FontEvent(font:String, type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this._font = font;
		}
	}
}