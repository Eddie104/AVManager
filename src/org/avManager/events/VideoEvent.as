package org.avManager.events
{
	import flash.events.Event;
	
	import org.avManager.model.data.VideoData;
	
	public final class VideoEvent extends Event
	{
		
		public static const COVER_LOADED:String = "coverLoaded";
		
		private var _videoData:VideoData;
			
		public function VideoEvent(type:String, videoData:VideoData)
		{
			super(type);
			_videoData = videoData;
		}

		public function get videoData():VideoData
		{
			return _videoData;
		}

	}
}