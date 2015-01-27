package org.avManager.model.data
{
	public class SQLData
	{
		
		protected var _id:int;
		
		protected var _name:String;
		
		public function SQLData()
		{
			
		}

		public function get id():int
		{
			return _id;
		}

		public function set id(value:int):void
		{
			_id = value;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}


	}
}