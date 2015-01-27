package org.avManager.model.sql
{
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.display.BitmapData;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.net.dns.AAAARecord;
	
	import org.libra.utils.bytes.BitmapBytes;

	public final class ActressTable extends Table
	{
		
//		private var _test:int = 0;
		
		public function ActressTable()
		{
			super();
			_tableName = "actress";
		}
		
		override public function createTable(sqlConnection:SQLConnection):void{
			_insertStatement.sqlConnection = sqlConnection;
			_insertStatement.text = "INSERT INTO " + _tableName + 
				" (ACTRESS_ID, NAME, BIRTHDAY, HEIGHT, CUP, BUST, WAIST, HIP, PORTRAIT) VALUES (@actressID, @name, @birthday, @height, @cup, @bust, @waist, @hip, @portrait)";
			_insertStatement.addEventListener(SQLEvent.RESULT, onInsertHandler);
			
			_queryStatement.sqlConnection = sqlConnection;
			_queryStatement.text = "select * from " + _tableName + " where ID=:id";
			_queryStatement.addEventListener(SQLEvent.RESULT, onQueryHandler);
//			stmt.addEventListener(SQLErrorEvent.ERROR,errorHandler);
			
			_deleteStatement.sqlConnection = sqlConnection;
			_deleteStatement.text = "delete from " + _tableName + " where ID=:id";
			
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
			
			var createStmt:SQLStatement = new SQLStatement(); 
			createStmt.sqlConnection = sqlConnection; 
			var sql:String = "CREATE TABLE IF NOT EXISTS " + _tableName + " (";
			const l:int = keyList.length;
			for(var i:int = 0;i < l;i++){
				sql += i == 0 ? keyList[i] : "," + keyList[i];
			}
			sql += ")";
			
			createStmt.text = sql;
			createStmt.addEventListener(SQLEvent.RESULT, function onCreateResult(event:SQLEvent):void{
				trace("初始化数据库成功");
				createStmt.removeEventListener(SQLEvent.RESULT, onCreateResult);
				/*
				//				SQLiteManager.instance._actressTable.insert();
				var idList:Vector.<int> = new Vector.<int>();
				idList[0] = 1;
				idList[1] = 14;
				idList[2] = 12;
				SQLiteManager.instance._actressTable.query(idList);
				trace("查好了");
				*/
			}); 
			createStmt.addEventListener(SQLErrorEvent.ERROR, function onCreateError(event:SQLErrorEvent):void{
				trace("创建table失败:Error message:", event.error.message, "Details:", event.error.details);
				createStmt.removeEventListener(SQLErrorEvent.ERROR, onCreateError);
			}); 
			createStmt.execute();
		}
		
		override public function insert():void{
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
		
		protected function onInsertHandler(evt:SQLEvent):void{
			var result:SQLResult = this._insertStatement.getResult();
			if(result.complete){
//				if(++_test < 10)
//					insert();
//				else
//					trace("好了");
				trace("好了");
			}
		}
		
		protected function onQueryHandler(evt:SQLEvent):void{
			var result:SQLResult = this._queryStatement.getResult();
			if ( result.data!=null )
			{
				var numResults:int = result.data.length;
				
				for (var i:int = 0; i < numResults; i++) 
				{ 
					var row:Object = result.data[i]; 
					var output:String = "ID: " + row.ID; 
					output += "; ACTRESS_ID: " + row.ACTRESS_ID; 
					output += "; NAME: " + row.NAME;
					output += "; BIRTHDAY: " + row.BIRTHDAY.fullYear;
					
					trace(output); 
					
//					var bmd:BitmapData = BitmapBytes.byteArrayToBitmapData(row.PORTRAIT);
//					trace(bmd);
				} 
			}
		}
	}
}