package org.avManager.model
{
	import flash.filesystem.File;
	
	import mx.controls.Alert;
	import org.avManager.model.sql.ActressTable;

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
		
	}
}

final class T{}