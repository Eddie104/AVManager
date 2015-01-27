package org.avManager.model.data
{
	import flash.display.BitmapData;

	public final class ActressData extends SQLData
	{
		
		private var _actressID:String;
		
		private var _birthday:Date;
		
		private var _height:int;
		
		private var _cup:String;
		
		private var _bust:int;
		
		private var _waist:int;
		
		private var _hip:int;
		
		private var _portrait:BitmapData;
		
		public function ActressData()
		{
			super();
		}

		public function get actressID():String
		{
			return _actressID;
		}

		public function set actressID(value:String):void
		{
			_actressID = value;
		}

		public function get birthday():Date
		{
			return _birthday;
		}

		public function set birthday(value:Date):void
		{
			_birthday = value;
		}

		public function get height():int
		{
			return _height;
		}

		public function set height(value:int):void
		{
			_height = value;
		}

		public function get cup():String
		{
			return _cup;
		}

		public function set cup(value:String):void
		{
			_cup = value;
		}

		public function get bust():int
		{
			return _bust;
		}

		public function set bust(value:int):void
		{
			_bust = value;
		}

		public function get waist():int
		{
			return _waist;
		}

		public function set waist(value:int):void
		{
			_waist = value;
		}

		public function get hip():int
		{
			return _hip;
		}

		public function set hip(value:int):void
		{
			_hip = value;
		}

		public function get portrait():BitmapData
		{
			return _portrait;
		}

		public function set portrait(value:BitmapData):void
		{
			_portrait = value;
		}


	}
}