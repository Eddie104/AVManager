package org.avManager.model.sql
{
	import flash.data.SQLConnection;
	import flash.events.SQLEvent;
	
	import org.avManager.model.data.ClassificationData;
	import org.avManager.model.data.SQLData;

	public final class ClassificationTable extends Table
	{
		public function ClassificationTable(sqlConnection:SQLConnection)
		{
			super(sqlConnection);
			_tableName = "classification";
		}
		
		override protected function init():void{
			super.init();
			_insertStatement.text = "INSERT INTO " + _tableName + 
				" (NAME) VALUES (@name)";
			
			var keyList:Vector.<String> = new Vector.<String>();
			keyList[0] = "ID INTEGER PRIMARY KEY AUTOINCREMENT";
			keyList[1] = "NAME NVARCHAR";
			_createSql = "CREATE TABLE IF NOT EXISTS " + _tableName + " (";
			const l:int = keyList.length;
			for(var i:int = 0;i < l;i++){
				_createSql += i == 0 ? keyList[i] : "," + keyList[i];
			}
			_createSql += ")";
		}
		
		override public function insert(sqlData:SQLData):void{
			var classification:ClassificationData = sqlData as ClassificationData;
			_insertStatement.parameters["@name"] = classification.name;
			_insertStatement.execute();
		}
		
		override protected function onCreateResult(event:SQLEvent):void{
			super.onCreateResult(event);
			
		}
		
	}
}