package org.avManager.model.sql
{
	import flash.data.SQLConnection;
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	
	import org.avManager.model.data.ActressData;
	import org.avManager.model.data.SQLData;
	import org.libra.utils.DateUtil;
	import org.libra.utils.bytes.BitmapBytes;

	public final class ActressTable extends Table
	{
		
		public function ActressTable(sqlConnection:SQLConnection)
		{
			_tableName = "actress";
			super(sqlConnection);
		}
		
		override protected function init():void{
			super.init();
			_insertStatement.text = "INSERT INTO " + _tableName + 
				" (ACTRESS_ID, NAME, BIRTHDAY, HEIGHT, CUP, BUST, WAIST, HIP, PORTRAIT, VIDEO) VALUES (@actressID, @name, @birthday, @height, @cup, @bust, @waist, @hip, @portrait, @video)";
			
			var keyList:Vector.<String> = new Vector.<String>();
			keyList[0] = "ID INTEGER PRIMARY KEY AUTOINCREMENT";
			keyList[1] = "ACTRESS_ID CHAR(3)";
			keyList[2] = "NAME NVARCHAR";
			keyList[3] = "BIRTHDAY DATE";
			keyList[4] = "HEIGHT SMALLINT";
			keyList[5] = "CUP CHAR(1)";
			keyList[6] = "BUST SMALLINT";
			keyList[7] = "WAIST SMALLINT";
			keyList[8] = "HIP SMALLINT";
			keyList[9] = "PORTRAIT BLOB";
			keyList[10] = "VIDEO BLOB";
			_createSql = "CREATE TABLE IF NOT EXISTS " + _tableName + " (";
			const l:int = keyList.length;
			for(var i:int = 0;i < l;i++){
				_createSql += i == 0 ? keyList[i] : "," + keyList[i];
			}
			_createSql += ")";
		}
		
		override public function insert(sqlData:SQLData, callback:Function = null):void{
			super.insert(sqlData, callback);
			var actressData:ActressData = sqlData as ActressData;
			_insertStatement.parameters["@actressID"] = actressData.actressID;
			_insertStatement.parameters["@name"] = actressData.name;
			_insertStatement.parameters["@birthday"] = DateUtil.toString(actressData.birthday);
			_insertStatement.parameters["@height"] = actressData.height;
			_insertStatement.parameters["@cup"] = actressData.cup;
			_insertStatement.parameters["@bust"] = actressData.bust;
			_insertStatement.parameters["@waist"] = actressData.waist;
			_insertStatement.parameters["@hip"] = actressData.hip;
			_insertStatement.parameters["@portrait"] = BitmapBytes.bitmapDataToByteArray(actressData.portrait);
			var b:ByteArray = new ByteArray();
			b.writeObject(actressData.video);
			_insertStatement.parameters["@video"] = b;
			_insertStatement.execute();
		}
		
	}
}