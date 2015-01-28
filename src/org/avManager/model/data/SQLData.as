package org.avManager.model.data
{
	public class SQLData
	{
		
		protected var _id:int;
		
		protected var _name:String;
		
		protected var _needInsert:Boolean;
		
		protected var _needUpdate:Boolean;
		
		public function SQLData(id:int)
		{
			_id = id;
		}

		public function get id():int
		{
			return _id;
		}
		
		[SQLData(cloName="NAME")]
		public function get name():String
		{
			return _name;
		}
		
		[Bindable]
		public function set name(value:String):void
		{
			_name = value;
		}

		public function get needInsert():Boolean
		{
			return _needInsert;
		}

		public function set needInsert(value:Boolean):void
		{
			_needInsert = value;
		}

		public function get needUpdate():Boolean
		{
			return _needUpdate;
		}

		public function set needUpdate(value:Boolean):void
		{
			_needUpdate = value;
		}


	}
}