package org.avManager.model.sql
{
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;

	public class Table
	{
		protected var _tableName:String = "tableName";
		
		protected var _insertStatement:SQLStatement;
		
		protected var _queryStatement:SQLStatement;
		
		protected var _deleteStatement:SQLStatement;
		
		public function Table()
		{
			_insertStatement = new SQLStatement();
			_queryStatement = new SQLStatement();
			_deleteStatement = new SQLStatement();
		}
		
		public function createTable(sqlConnection:SQLConnection):void{
			
		}
		
		public function insert():void{
			
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
	}
}