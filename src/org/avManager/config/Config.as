package org.avManager.config
{
	public final class Config
	{
		
		private static var _instance:Config;
		
		private var _now:Date = new Date();
		
		private var _defaultDate:Date = new Date(1900, 1, 1);
		
		public function Config(t:T)
		{
		}
		
		public function get defaultDate():Date
		{
			return _defaultDate;
		}

		public function get now():Date
		{
			return _now;
		}

		public static function get instance():Config{
			if(!_instance) _instance = new Config(new T());
			return _instance;
		}
	}
}

final class T{}