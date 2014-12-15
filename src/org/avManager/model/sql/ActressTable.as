package org.avManager.model.sql
{
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.SQLEvent;
	import flash.net.dns.AAAARecord;

	public final class ActressTable
	{
		
		private var _tableName:String = "actress";
		
		private var _insertStatement:SQLStatement;
		
		private var _test:int = 0;
		
		public function ActressTable()
		{
			_insertStatement = new SQLStatement();
		}
		
		public function createTable(sqlConnection:SQLConnection):void{
			_insertStatement.sqlConnection = sqlConnection;
			_insertStatement.text="INSERT INTO " + _tableName + 
				" (ACTRESS_ID, NAME, BIRTHDAY, HEIGHT, CUP, BUST, WAIST, HIP) VALUES (@actressID, @name, @birthday, @height, @cup, @bust, @waist, @hip)";
			// , PORTRAIT   , @portrait
			_insertStatement.addEventListener(SQLEvent.RESULT, onInsertHandler);
			
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
			SQLiteManager.createTable(sqlConnection, _tableName, keyList);
		}
		
		public function insert():void{
			_insertStatement.parameters["@actressID"]="a3f";
			_insertStatement.parameters["@name"]="みづき伊織";
			_insertStatement.parameters["@birthday"]="1986-10-04";
			_insertStatement.parameters["@height"]=188;
			_insertStatement.parameters["@cup"]="F";
			_insertStatement.parameters["@bust"]=88;
			_insertStatement.parameters["@waist"]=88;
			_insertStatement.parameters["@hip"]=88;
			//			_insertStatement.parameters["@portrait"]=88;
			_insertStatement.execute();
		}
		
		private function onInsertHandler(evt:SQLEvent):void{
			var result:SQLResult = this._insertStatement.getResult();
			if(result.complete){
				if(++_test < 10)
					insert();
				else
					trace("好了");
			}
		}
	}
}