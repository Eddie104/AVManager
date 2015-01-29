package org.avManager.events
{
	import flash.events.Event;
	
	public final class ClassificationEvent extends Event
	{
		
		public static const SWITCH:String = "switch";
		
		private var _curIndex:int;
		
		public function ClassificationEvent(type:String, curIndex:int)
		{
			super(type);
			_curIndex = curIndex;
		}
		
		/**
		 * 0:电影，1:演员
		 */
		public function get curIndex():int
		{
			return _curIndex;
		}

	}
}