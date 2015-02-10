package org.avManager.model
{
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	
	import org.avManager.model.data.ActressData;
	import org.libra.utils.bytes.BitmapBytes;

	public final class ActressManager
	{
		
		private static var _instance:ActressManager;
		
		private var _actressList:ArrayCollection = new ArrayCollection();
		
		private var _initCallback:Function;
		
		private var _saveCallback:Function;
		
		private var _saveIndex:int = 0;
		
		public function ActressManager(t:T)
		{
			
		}
		
		public function init(callback:Function):void{
			_initCallback = callback;
			SQLiteManager.instance.actressTable.query(onQuery);
		}
		
		private function onQuery(result:Array):void{
			const l:int = result.length;
			var actressData:ActressData;
			var data:Object;
			for(var i:int = 0;i < l;i++){
				data = result[i];
				actressData = new ActressData(data.ID);
				actressData.needInsert = false;
				actressData.name = data.NAME;
				actressData.actressID = data.ACTRESS_ID;
				actressData.birthday = data.BIRTHDAY;
				actressData.bust = data.BUST;
				actressData.cup = data.CUP;
				actressData.height = data.HEIGHT;
				actressData.hip = data.HIP;
				actressData.portrait = BitmapBytes.byteArrayToBitmapData(data.PORTRAIT);
				actressData.waist = data.WAIST;
				var b:ByteArray = data.VIDEO;
				if(b){
					actressData.video = b.readObject();
				}
				actressData.alias = data.ALIAS;
				actressData.score = data.SCORE;
				this._actressList.addItem(actressData);
				actressData.needUpdate = false;
			}
			_initCallback();
		}
		
		public function save(callback:Function = null):void{
			_saveCallback = callback;
			this.saveActressData();
		}
		
		private function saveActressData():void
		{
			if(_saveIndex >= this._actressList.length){
				if(_saveCallback != null) _saveCallback();
			}else{
				var actressData:ActressData = this._actressList.getItemAt(_saveIndex++) as ActressData;
				if(actressData.needInsert){
					actressData.needInsert = false;
					SQLiteManager.instance.actressTable.insert(actressData, saveActressData);
				}else if(actressData.needUpdate){
					actressData.needUpdate = false;
					SQLiteManager.instance.actressTable.update(actressData, saveActressData);
				}else{
					this.saveActressData();
				}
			}
		}
		
		public function getActressList():Vector.<ActressData>{
			var list:Vector.<ActressData> = new Vector.<ActressData>();
			for each(var actress:ActressData in _actressList){
				list.push(actress);
			}
			return list;
		}
		
		public function getActressByName(name:String):ActressData{
			for each(var actress:ActressData in _actressList){
				if(actress.name == name) return actress;
			}
			return null;	
		}
		
		public function getActressByActressID(id:String):ActressData{
			for each(var actress:ActressData in _actressList){
				if(actress.actressID == id) return actress;
			}
			return null;
		}
		
		public function getActressByCup(cup:String):Vector.<ActressData>{
			if(cup == "ALL"){
				return getActressList();
			}else{
				var list:Vector.<ActressData> = new Vector.<ActressData>();
				for each(var actress:ActressData in _actressList){
					if(actress.cup == cup) list.push(actress);
				}
				return list;				
			}
		}
		
		public function createActress(id:String, name:String):ActressData{
			var actress:ActressData = this.getActressByActressID(id);
			if(!actress){
				actress = new ActressData(this._actressList.length + 1);
				actress.needInsert = true;
				actress.actressID = id;
				actress.name = name;
				this._actressList.addItem(actress);
			}
			return actress;
		}
		
		public static function get instance():ActressManager{
			if(!_instance) _instance = new ActressManager(new T());
			return _instance;
		}
	}
}

final class T{}