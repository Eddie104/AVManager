package org.avManager.model.data
{
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
		
		private var _video:Array = [];
		
		private var _score:int = 1;
		
		private var _alias:String;
		
		private var _rank:int = 0;
		
		public function ActressData(id:int)
		{
			super(id);
			this.birthday = new Date(Config.instance.defaultDate.fullYear, Config.instance.defaultDate.month, Config.instance.defaultDate.date);
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
		
		public function addVideo(videoID:String):void{
			if(this._video.indexOf(videoID) == -1){
				this._video.push(videoID);
				_workCount++;
				this.needUpdate = true;
			}
		}

		[SQLData(cloName="ACTRESS_ID")]
		public function get actressID():String
		{
			return _actressID;
		}

		[Bindable]
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
		
		public function get birthdayFullYear():String{
			return _birthday.fullYear.toString();
		}
		
		[Bindable]
		public function set birthdayFullYear(value:String):void{
			var year:int = int(value);
			if(year > 0){
				this._birthday.fullYear = year;
				this._needUpdate = true;
			}
		}
		
		public function get birthdayMonth():String{
			return (_birthday.month + 1).toString();
		}
		
		[Bindable]
		public function set birthdayMonth(value:String):void{
			var month:int = int(value);
			if(month > 0){
				this._birthday.month = month - 1;
				this._needUpdate = true;
			}
		}
		
		public function get birthdayDate():String{
			return _birthday.date.toString();
		}
		
		[Bindable]
		public function set birthdayDate(value:String):void{
			var date:int = int(value);
			if(date > 0){
				this._birthday.date = date;
				this._needUpdate = true;
			}
		}
		
		[SQLData(cloName="HEIGHT")]
		public function get height():String
		{
			return _height.toString();
		}

		[Bindable]
		public function set height(value:String):void
		{
			_height = int(value);
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
			_cup = value.toLocaleUpperCase();
			this.needUpdate = true;
		}

		[SQLData(cloName="BUST")]
		public function get bust():String
		{
			return _bust.toString();
		}

		[Bindable]
		public function set bust(value:String):void
		{
			_bust = int(value);
			this.needUpdate = true;
		}

		[SQLData(cloName="WAIST")]
		public function get waist():String
		{
			return _waist.toString();
		}

		[Bindable]
		public function set waist(value:String):void
		{
			_waist = int(value);
			this.needUpdate = true;
		}

		[SQLData(cloName="HIP")]
		public function get hip():String
		{
			return _hip.toString();
		}

		[Bindable]
		public function set hip(value:String):void
		{
			_hip = int(value);
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
		
		[Bindable]
		public function set workCount(value:int):void{
			this._waist = value;
		}

		[SQLData(cloName="VIDEO",type="Array")]
		public function get video():Array
		{
			return _video;
		}

		[Bindable]
		public function set video(value:Array):void
		{
			_video = value;
			_workCount = _video ? _video.length : 0;
			this.needUpdate = true;
		}

		[SQLData(cloName="SCORE")]
		public function get score():int
		{
			return _score;
		}

		[Bindable]
		public function set score(value:int):void
		{
			_score = value;
			this.needUpdate = true;
		}

		[SQLData(cloName="ALIAS")]
		public function get alias():String
		{
			return _alias;
		}

		[Bindable]
		public function set alias(value:String):void
		{
			_alias = value;
			this.needUpdate = true;
		}

		[SQLData(cloName="RANK")]
		public function get rank():int
		{
			return _rank;
		}

		[Bindable]
		public function set rank(value:int):void
		{
			_rank = value;
			this.needUpdate = true;
		}
		
		public function get rankStr():String{
			return this.rank.toString();
		}
		
		[Bindable]
		public function set rankStr(value:String):void{
			this.rank = int(value);
		}


	}
}