package org.avManager.model.data
{
	import avmplus.FLASH10_FLAGS;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	import org.avManager.config.Config;
	import org.libra.log4a.Logger;

	public final class ActressData extends SQLData
	{
		
		private var _actressID:String;
		
		private var _birthday:Date;
		
		private var _height:int;
		
		private var _cup:String = "0";
		
		private var _bust:int;
		
		private var _waist:int;
		
		private var _hip:int;
		
		private var _portrait:BitmapData;
		
		private var _age:int;
		
		private var _workCount:int;
		
		public function ActressData(id:int)
		{
			super(id);
			this.birthday = Config.instance.defaultDate;
		}
		
		public function setPortraitURL(url:String):void{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadPortraitCompleted);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadIOError);
			loader.load(new URLRequest(url));
		}
		
		private function onLoadIOError(event:IOErrorEvent):void
		{
			var loaderInfo:LoaderInfo = event.target as LoaderInfo;
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onLoadIOError);
			loaderInfo.removeEventListener(Event.COMPLETE, onLoadPortraitCompleted);
			Logger.error(event.text);
		}
		
		private function onLoadPortraitCompleted(event:Event):void
		{
			var loaderInfo:LoaderInfo = event.target as LoaderInfo;
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onLoadIOError);
			loaderInfo.removeEventListener(Event.COMPLETE, onLoadPortraitCompleted);
			
			this.portrait = (loaderInfo.content as Bitmap).bitmapData;
			Logger.info(this._name + "的头像下好了");
		}

		[SQLData(cloName="ACTRESS_ID")]
		public function get actressID():String
		{
			return _actressID;
		}

		public function set actressID(value:String):void
		{
			_actressID = value;
			this.needUpdate = true;
		}

		[SQLData(cloName="BIRTHDAY")]
		public function get birthday():Date
		{
			return _birthday;
		}

		[Bindable]
		public function set birthday(value:Date):void
		{
			_birthday = value;
			_age = Config.instance.now.fullYear - value.fullYear;
			this.needUpdate = true;
		}

		[SQLData(cloName="HEIGHT")]
		public function get height():int
		{
			return _height;
		}

		[Bindable]
		public function set height(value:int):void
		{
			_height = value;
			this.needUpdate = true;
		}

		[SQLData(cloName="CUP")]
		public function get cup():String
		{
			return _cup;
		}

		[Bindable]
		public function set cup(value:String):void
		{
			_cup = value;
			this.needUpdate = true;
		}

		[SQLData(cloName="BUST")]
		public function get bust():int
		{
			return _bust;
		}

		[Bindable]
		public function set bust(value:int):void
		{
			_bust = value;
			this.needUpdate = true;
		}

		[SQLData(cloName="WAIST")]
		public function get waist():int
		{
			return _waist;
		}

		[Bindable]
		public function set waist(value:int):void
		{
			_waist = value;
			this.needUpdate = true;
		}

		[SQLData(cloName="HIP")]
		public function get hip():int
		{
			return _hip;
		}

		[Bindable]
		public function set hip(value:int):void
		{
			_hip = value;
			this.needUpdate = true;
		}

		[SQLData(cloName="PORTRAIT",type="BitmapData")]
		public function get portrait():BitmapData
		{
			return _portrait;
		}

		[Bindable]
		public function set portrait(value:BitmapData):void
		{
			_portrait = value;
			this.needUpdate = true;
		}

		public function get age():int
		{
			return _age;
		}

		public function get workCount():int
		{
			return _workCount;
		}


	}
}