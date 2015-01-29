package org.avManager.model
{
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	
	import org.avManager.model.data.VideoData;
	import org.libra.utils.bytes.BitmapBytes;

	public final class VideoManager
	{
		
		private static var _instance:VideoManager;
		
		private var _videoDataList:ArrayCollection = new ArrayCollection();
		
		private var _saveIndex:int = 0;
		
		private var _saveCallback:Function;
		
		public function VideoManager(t:T)
		{
			
		}
		
		public function init():void{
			SQLiteManager.instance.videoTable.query(onQuery);
		}
		
		private function onQuery(result:Array):void{
			const l:int = result.length;
			var videoData:VideoData;
			var data:Object;
			for(var i:int = 0;i < l;i++){
				data = result[i];
				videoData = new VideoData(data.ID);
				videoData.needInsert = false;
				videoData.name = data.NAME;
				var b:ByteArray = data.CLASSIFICATION as ByteArray;
				videoData.classification = b.readObject() as Array;
				videoData.cover = BitmapBytes.byteArrayToBitmapData(data.COVER);
				videoData.coverSub = BitmapBytes.byteArrayToBitmapData(data.COVER_SUB);
				videoData.date = data.DATE;
				videoData.videoID = data.VIDEO_ID;
				videoData.torrent = data.TORRENT;
				this._videoDataList.addItem(videoData);
			}
		}
		
		public function save(callback:Function = null):void{
			_saveCallback = callback;
			this.saveVideData();
		}
		
		private function saveVideData():void
		{
			if(_saveIndex >= this._videoDataList.length){
				if(_saveCallback != null) _saveCallback();
			}else{
				var videoData:VideoData = this._videoDataList.getItemAt(_saveIndex++) as VideoData;
				if(videoData.needInsert){
					videoData.needInsert = false;
					SQLiteManager.instance.videoTable.insert(videoData, saveVideData);
				}else if(videoData.needUpdate){
					videoData.needUpdate = false;
					SQLiteManager.instance.videoTable.update(videoData, saveVideData);
				}else{
					this.saveVideData();
				}
			}
		}
		
		public function getVideoDataByVideoID(videoID:String):VideoData{
			videoID = videoID.toLowerCase();
			for each(var videoData:VideoData in this._videoDataList){
				if(videoData.videoID.toLowerCase() == videoID) return videoData;
			}
			return null;
		}
		
		public function getVideoDataListByClassification(classificationName:String):Vector.<VideoData>{
			var list:Vector.<VideoData> = new Vector.<VideoData>();
			for each(var videoData:VideoData in this._videoDataList){
				if(!classificationName || classificationName == "所有" || videoData.hasClassification(classificationName)){
					list.push(videoData);
				}
			}
			return list;
		}
		
		public function createVideoID(videoID:String):VideoData{
			var videoData:VideoData = getVideoDataByVideoID(videoID);
			if(!videoData){
				videoData = new VideoData(this._videoDataList.length + 1);
				videoData.needInsert = true;
				videoData.videoID = videoID;
				this._videoDataList.addItem(videoData);
			}
			return videoData;
		}
		
		public static function get instance():VideoManager{
			if(!_instance) _instance = new VideoManager(new T());
			return _instance;
		}
	}
}

final class T{}