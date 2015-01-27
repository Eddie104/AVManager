package org.avManager.config
{
	public final class Config
	{
		
		private static var _instance:Config;
		
		public function Config(t:T)
		{
		}
		
		public static function get instance():Config{
			if(!_instance) _instance = new Config(new T());
			return _instance;
		}
	}
}

final class T{}