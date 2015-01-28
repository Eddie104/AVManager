package org.avManager.model.sql
{
	import flash.data.SQLConnection;
	
	import org.avManager.model.data.ClassificationData;
	import org.avManager.model.data.SQLData;

	public final class ClassificationTable extends Table
	{
		public function ClassificationTable(sqlConnection:SQLConnection)
		{
			_tableName = "classification";
			super(sqlConnection);
		}
		
		override protected function init():void{
			super.init();
			_insertStatement.text = "INSERT INTO " + _tableName + " (NAME) VALUES (@name)";
			
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
		
		override public function insert(sqlData:SQLData, callback:Function = null):void{
			super.insert(sqlData, callback);
			var classification:ClassificationData = sqlData as ClassificationData;
			_insertStatement.parameters["@name"] = classification.name;
			_insertStatement.execute();
		}
		
		//==============start test======================================
//		override protected function onCreateResult(event:SQLEvent):void{
//			super.onCreateResult(event);
//			test();
//		}
//		
//		private var testDataList:Vector.<ClassificationData>;
//		private var testIndex:int = -1;
//		private function test():void{
//			if(!testDataList){
//				testDataList = new Vector.<ClassificationData>(10);
//				for(var i:int = 0;i < 10;i++){
//					testDataList[i] = new ClassificationData();
//					testDataList[i].id = i;
//					testDataList[i].name = "test" + i;
//				}
//			}
//			trace(testIndex);
//			if(++testIndex < 10){
//				this.insert(this.testDataList[testIndex], this.test);				
//			}
//		}
		//==============end test======================================
	}
}