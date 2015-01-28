package org.avManager.model.sql
{
	import flash.data.SQLConnection;
	import flash.display.BitmapData;
	
	import org.avManager.model.data.ActressData;
	import org.avManager.model.data.SQLData;
	import org.libra.utils.bytes.BitmapBytes;

	public final class ActressTable extends Table
	{
		
//		private var _test:int = 0;
		
		public function ActressTable(sqlConnection:SQLConnection)
		{
			_tableName = "actress";
			super(sqlConnection);
		}
		
		override protected function init():void{
			super.init();
			_insertStatement.text = "INSERT INTO " + _tableName + 
				" (ACTRESS_ID, NAME, BIRTHDAY, HEIGHT, CUP, BUST, WAIST, HIP, PORTRAIT) VALUES (@actressID, @name, @birthday, @height, @cup, @bust, @waist, @hip, @portrait)";
			//			stmt.addEventListener(SQLErrorEvent.ERROR,errorHandler);
			
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
			_insertStatement.parameters["@actressID"] = "a3f";
			_insertStatement.parameters["@name"] = "みづき伊織";
			_insertStatement.parameters["@birthday"] = "1986-10-04";
			_insertStatement.parameters["@height"] = 188;
			_insertStatement.parameters["@cup"] = "F";
			_insertStatement.parameters["@bust"] = 88;
			_insertStatement.parameters["@waist"] = 88;
			_insertStatement.parameters["@hip"] = 88;
			var bmd:BitmapData= new BitmapData(50,50,true,0xff00ff);
			_insertStatement.parameters["@portrait"]=BitmapBytes.bitmapDataToByteArray(bmd);
			_insertStatement.execute();
		}
		
	}
}