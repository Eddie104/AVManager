package org.avManager.model
{
	import org.avManager.model.data.ActressData;

	public final class ActressManager
	{
		
		private static var _instance:ActressManager;
		
		private var _actressList:Vector.<ActressData> = new Vector.<ActressData>();
		
		public function ActressManager(t:T)
		{
			
		}
		
		public static function get instance():ActressManager{
			if(!_instance) _instance = new ActressManager(new T());
			return _instance;
		}
	}
}

final class T()