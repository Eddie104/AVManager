package org.avManager.model.sql
{
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	
	import org.avManager.model.data.SQLData;
	import org.libra.log4a.Logger;

	public class Table
	{
		protected var _tableName:String = "tableName";
		
		protected var _createSql:String;
		
		protected var _sqlConnection:SQLConnection;
		
		protected var _createStmt:SQLStatement;
		
		protected var _insertStatement:SQLStatement;
		
		protected var _queryStatement:SQLStatement;
		
		protected var _deleteStatement:SQLStatement;
		
		public function Table(sqlConnection:SQLConnection)
		{
			_sqlConnection = sqlConnection;
			_insertStatement = new SQLStatement();
			_queryStatement = new SQLStatement();
			_deleteStatement = new SQLStatement();
			this.init();
		}
		
		protected function init():void
		{
			_insertStatement.sqlConnection = _sqlConnection;
			_insertStatement.addEventListener(SQLEvent.RESULT, onInsertHandler);
			
			_queryStatement.sqlConnection = _sqlConnection;
			_queryStatement.text = "select * from " + _tableName + " where ID=:id";
			_queryStatement.addEventListener(SQLEvent.RESULT, onQueryHandler);
			
			_deleteStatement.sqlConnection = _sqlConnection;
			_deleteStatement.text = "delete from " + _tableName + " where ID=:id";
			_deleteStatement.addEventListener(SQLEvent.RESULT, onDeleteHandler);
		}
		
		public function createTable():void{
			_createStmt = new SQLStatement(); 
			_createStmt.sqlConnection = _sqlConnection; 
			_createStmt.text = _createSql;
			_createStmt.addEventListener(SQLEvent.RESULT, onCreateResult); 
			_createStmt.addEventListener(SQLErrorEvent.ERROR, function onCreateError(event:SQLErrorEvent):void{
				Logger.error("创建table" +  _tableName + "失败:Error message:" + event.error.message + "Details:" + event.error.details);
				_createStmt.removeEventListener(SQLErrorEvent.ERROR, onCreateError);
			});
			_createStmt.execute();
		}
		
		public function insert(sqlData:SQLData):void{
			
		}
		
		public function query(idList:Vector.<int> = null):void{
			if(idList){
				var idListStr:String = "(";
				for(var i:int = 0;i < idList.length;i++){
					idListStr += i == 0 ? idList[i] : "," + idList[i];
				}
				idListStr += ")";
				_queryStatement.text = "select * from " + _tableName + " where ID in " + idListStr;
			}else{
				_queryStatement.text = "select * from " + _tableName;
			}
			_queryStatement.execute(); 
		}
		
		public function del(idList:Vector.<int> = null):void{
			if(idList){
				var idListStr:String = "(";
				for(var i:int = 0;i < idList.length;i++){
					idListStr += i == 0 ? idList[i] : "," + idList[i];
				}
				idListStr += ")";
				_deleteStatement.text = "delete from " + _tableName + " where ID in " + idListStr;
			}else{
				_deleteStatement.text = "delete from " + _tableName;
			}
			_deleteStatement.execute(); 
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
		
		protected function onDeleteHandler(evt:SQLEvent):void{
			var result:SQLResult = this._deleteStatement.getResult();
			Logger.info("删除行数:" + result.rowsAffected);
		}
		
		protected function onCreateResult(event:SQLEvent):void{
			Logger.info("初始化数据库成功" + _tableName);
			_createStmt.removeEventListener(SQLEvent.RESULT, onCreateResult);
			/*
			//				SQLiteManager.instance._actressTable.insert();
			var idList:Vector.<int> = new Vector.<int>();
			idList[0] = 1;
			idList[1] = 14;
			idList[2] = 12;
			SQLiteManager.instance._actressTable.query(idList);
			trace("查好了");
			*/
		}
	}
}