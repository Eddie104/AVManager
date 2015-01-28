package org.avManager.model.sql
{
	import flash.data.SQLConnection;
	import flash.utils.ByteArray;
	
	import org.avManager.model.data.SQLData;
	import org.avManager.model.data.VideoData;
	import org.libra.utils.DateUtil;
	import org.libra.utils.bytes.BitmapBytes;
	
	public final class VideoTable extends Table
	{
		public function VideoTable(sqlConnection:SQLConnection)
		{
			_tableName = "video";
			super(sqlConnection);
		}
		
		override protected function init():void{
			super.init();
			_insertStatement.text = "INSERT INTO " + _tableName + 
				" (NAME, VIDEO_ID, DATE, COVER, COVER_SUB, CLASSIFICATION) VALUES (@name, @videoID, @date, @cover, @coverSub, @classification)";
			
			var keyList:Vector.<String> = new Vector.<String>();
			keyList[0] = "ID INTEGER PRIMARY KEY AUTOINCREMENT";
			keyList[1] = "NAME NVARCHAR";
			keyList[2] = "VIDEO_ID NVARCHAR";
			keyList[3] = "DATE DATE";
			keyList[4] = "COVER BLOB";
			keyList[5] = "COVER_SUB BLOB";
			keyList[6] = "CLASSIFICATION BLOB";
			_createSql = "CREATE TABLE IF NOT EXISTS " + _tableName + " (";
			const l:int = keyList.length;
			for(var i:int = 0;i < l;i++){
				_createSql += i == 0 ? keyList[i] : "," + keyList[i];
			}
			_createSql += ")";
		}
		
		override public function insert(sqlData:SQLData, callback:Function = null):void{
			super.insert(sqlData, callback);
			var videoData:VideoData = sqlData as VideoData;
			_insertStatement.parameters["@name"] = videoData.name;
			_insertStatement.parameters["@videoID"] = videoData.videoID;
			_insertStatement.parameters["@date"] = videoData.date;
			_insertStatement.parameters["@cover"] = BitmapBytes.bitmapDataToByteArray(videoData.cover);
			_insertStatement.parameters["@coverSub"] = BitmapBytes.bitmapDataToByteArray(videoData.coverSub);
			var b:ByteArray = new ByteArray();
			b.writeObject(videoData.classification);
			_insertStatement.parameters["@classification"] = b;
			_insertStatement.execute();
		}
		
		//==============start test======================================
//			override protected function onCreateResult(event:SQLEvent):void{
//				super.onCreateResult(event);
//				test();
//			}
//			
//			private function test():void{
////				var t:VideoData = new VideoData();
////				t.classification = [1, 2, 3];
////				t.cover = new BitmapData(50,50);
////				t.coverSub = new BitmapData(60,60);
////				t.date = new Date();
////				t.name = "dsfsd";
////				t.videoID = "tt-023";
////				this.insert(t, function():void{trace("插入完毕");});
//				
////				this.query(function(result:Array):void{
////					var t:Object = result[0];
////					var b:ByteArray = t.CLASSIFICATION as ByteArray;
////					t = b.readObject();
////					trace(t);
////				});
//			}
		//==============end test======================================		
	}
}