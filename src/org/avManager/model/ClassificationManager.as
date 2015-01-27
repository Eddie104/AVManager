package org.avManager.model
{
	import org.avManager.model.data.ClassificationData;

	public final class ClassificationManager
	{
		
		private static var _instance:ClassificationManager;
		
		private var _classificationList:Vector.<ClassificationData> = new Vector.<ClassificationData>();
		
		public function ClassificationManager(t:T)
		{
		}
		
		public function init():void{
			SQLiteManager.instance.classificationTable.query();
		}
		
		public static function get instance():ClassificationManager{
			if(!_instance) _instance = new ClassificationManager(new T());
			return _instance;
		}
	}
}

final class T{}