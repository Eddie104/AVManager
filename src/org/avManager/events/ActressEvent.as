package org.avManager.events
{
	import flash.events.Event;
	
	public final class ActressEvent extends Event
	{
		public static const DELETED:String = "deleted";
		
		public function ActressEvent(type:String)
		{
			super(type);
		}
	}
}