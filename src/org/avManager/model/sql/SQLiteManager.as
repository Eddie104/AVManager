package org.avManager.model.sql
{
	import flash.filesystem.File;
	
	import mx.controls.Alert;

	public final class SQLiteManager
	{
		
		import flash.data.SQLConnection;
		import flash.data.SQLStatement;
		import flash.events.SQLErrorEvent;
		import flash.events.SQLEvent;
		
		private static var _instance:SQLiteManager;
		
		private var _sqlConnection:SQLConnection;
		
		private var _actressTable:ActressTable;
		
		public function SQLiteManager(t:T)
		{
			_actressTable = new ActressTable();
		}
		
		public function init(dbFile:File):void{
			_sqlConnection = new SQLConnection();
			//在 openAsync() 方法调用操作成功完成时调度
			_sqlConnection.addEventListener(SQLEvent.OPEN,openHandler);
			//SQLConnection 对象的异步操作导致错误时调度
			_sqlConnection.addEventListener(SQLErrorEvent.ERROR,errorHandler);
			
			_sqlConnection.openAsync(dbFile);
		}
		
		private function openHandler(evt:SQLEvent):void{
			_sqlConnection.removeEventListener(SQLEvent.OPEN,openHandler);
			_sqlConnection.removeEventListener(SQLErrorEvent.ERROR,errorHandler);
			// 开始创建表
			_actressTable.createTable(_sqlConnection);
		}
		
		private function errorHandler(evt:SQLErrorEvent):void{
			_sqlConnection.removeEventListener(SQLEvent.OPEN,openHandler);
			_sqlConnection.removeEventListener(SQLErrorEvent.ERROR,errorHandler);
			Alert.show("打开数据库失败:" + evt.text);
		}
		
		public static function get instance():SQLiteManager{
			if(!_instance) _instance = new SQLiteManager(new T());
			return _instance;
		}
		
		public static function createTable(sqlConnection:SQLConnection, tableName:String, keyList:Vector.<String>):void{
			var createStmt:SQLStatement = new SQLStatement(); 
			createStmt.sqlConnection = sqlConnection; 
			var sql:String = "CREATE TABLE IF NOT EXISTS " + tableName + " (";
			const l:int = keyList.length;
			for(var i:int = 0;i < l;i++){
				sql += i == 0 ? keyList[i] : "," + keyList[i];
			}
			sql += ")";
			
			createStmt.text = sql;
			createStmt.addEventListener(SQLEvent.RESULT, function onCreateResult(event:SQLEvent):void{
				trace("初始化数据库成功");
				createStmt.removeEventListener(SQLEvent.RESULT, onCreateResult);
				SQLiteManager.instance._actressTable.insert();
				trace("查好了");
			}); 
			createStmt.addEventListener(SQLErrorEvent.ERROR, function onCreateError(event:SQLErrorEvent):void{
				trace("创建table失败:Error message:", event.error.message, "Details:", event.error.details);
				createStmt.removeEventListener(SQLErrorEvent.ERROR, onCreateError);
			}); 
			createStmt.execute();
		}
	}
}

final class T{}