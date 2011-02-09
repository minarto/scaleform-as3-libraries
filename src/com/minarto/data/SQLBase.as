package com.minarto.data
{
	import flash.data.SQLConnection;
	import flash.data.SQLMode;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.Event;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	
	import com.minarto.events.DefaultEventDispatcher;
	
	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class SQLBase extends DefaultEventDispatcher
	{
		/**
		 * 
		 */		
		public var filePath:String;
		
		
		private var __connection:SQLConnection;
		public function get connection():SQLConnection
		{
			return	__connection;
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function SQLBase()
		{
			init();
		}
		
		
		override public function destroy():void
		{
			if(__connection)
			{
				__connection.removeEventListener(SQLErrorEvent.ERROR, dispatchEvent);
				__connection.removeEventListener(SQLEvent.OPEN, hnOpen);
				__connection.removeEventListener(SQLEvent.BEGIN, dispatchEvent);
				__connection.removeEventListener(SQLEvent.COMMIT, dispatchEvent);
			}
			
			try
			{
				__connection.close();
			}
			catch(error:Error)	{}
			
			__connection = null;
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function open($type:String=null):void
		{
			destroy();
			
			__connection = new SQLConnection();
			__connection.addEventListener(SQLErrorEvent.ERROR, dispatchEvent);
			__connection.addEventListener(SQLEvent.OPEN, hnOpen);
			
			switch(($type || "").toLowerCase())
			{
				case "desktop":
					var file:File = File.desktopDirectory;
					break;
				case "application":
					file = File.applicationDirectory;
					break;
				default :
					file = File.applicationStorageDirectory;
			}
			__connection.openAsync(file.resolvePath(filePath));
		}
		
		
		/**
		 * 
		 * 
		 */		
		protected function hnOpen($e:SQLEvent):void
		{
			__connection.removeEventListener(SQLEvent.OPEN, hnOpen);
			__connection.addEventListener(SQLEvent.BEGIN, hnBegin);
			__connection.begin();
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function lastSaveFileLoad($id:String):void
		{
			
		}
		
		
		/**
		 * 
		 * 
		 */		
		protected function hnBegin($e:SQLEvent):void
		{
			__connection.removeEventListener(SQLEvent.BEGIN, dispatchEvent);
			
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = __connection;
			sqlStatement.text = "CREATE TABLE IF NOT EXISTS saveData (date Date, id TEXT, title TEXT, description TEXT)";

			sqlStatement.addEventListener(SQLEvent.RESULT, hnCreateResult);
			sqlStatement.addEventListener(SQLErrorEvent.ERROR, dispatchEvent);
			
			sqlStatement.execute();
		}
		
		
		/**
		 * 
		 * 
		 */		
		protected function hnCreateResult($e:SQLEvent):void
		{
			var sqlStatement:SQLStatement = $e.target as SQLStatement;
			sqlStatement.removeEventListener(SQLEvent.RESULT, hnCreateResult);
			sqlStatement.removeEventListener(SQLErrorEvent.ERROR, dispatchEvent);
			
			dispatchEvent(new SQLEvent(SQLEvent.BEGIN));
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function commit():void
		{
			__connection.addEventListener(SQLEvent.COMMIT, hnCommit);
			__connection.commit();
		}
		
		
		/**
		 * 
		 * 
		 */		
		protected function hnCommit($e:SQLEvent):void
		{
			__connection.removeEventListener(SQLEvent.COMMIT, hnCommit);
			__connection.close();
			open();
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function save($id:String, $title:String, $description:String):void
		{
			__connection.removeEventListener(SQLEvent.BEGIN, dispatchEvent);
			
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = __connection;
			sqlStatement.text = "INSERT INTO saveData (date, id, title, description) VALUES (:date, :id, :title, :description)";

			sqlStatement.parameters[":date"] = new Date();
			sqlStatement.parameters[":id"] = $id;
			sqlStatement.parameters[":title"] = $title;
			sqlStatement.parameters[":description"] = $description;

			sqlStatement.addEventListener(SQLEvent.RESULT, hnResult);
			sqlStatement.addEventListener(SQLErrorEvent.ERROR, dispatchEvent);
			
			sqlStatement.execute();
		}
		
		
		/**
		 * 
		 * 
		 */		
		protected function hnResult($e:SQLEvent):void
		{
			var sqlStatement:SQLStatement = $e.target as SQLStatement;
			sqlStatement.removeEventListener(SQLEvent.RESULT, hnResult);
			sqlStatement.removeEventListener(SQLErrorEvent.ERROR, dispatchEvent);
			
			var result:SQLResult = sqlStatement.getResult();
			var index:Number = result.lastInsertRowID;
			trace(index);
		}
	}
}