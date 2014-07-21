package com.lolin.NS.app.model.NSCollection
{
	import com.lolin.NS.app.model.NSDB.NSDB;
	
	import flash.data.SQLConnection;
	import flash.errors.SQLError;
	import flash.filesystem.File;
	
	import mx.controls.Alert;
	
	public class NSConnection
	{
		private var _conn:SQLConnection = null;
		
		public function NSConnection()
		{
		}
		
		public function getConnection():SQLConnection{
			if(_conn == null) initConnection();
			return _conn;
		}
		
		public function closeConnection():void{
			if(_conn != null) {
				try{
					_conn.close();
				}catch(error:SQLError){
					Alert.show("connection close error, "+error.message);
				}
				_conn = null;
			}
		}
		
		private function initConnection():void{
			_conn = new SQLConnection();
			var dbFile:File = NSDB.DB;
			try { 
				_conn.open(dbFile); 
				trace("the database was created successfully"); 
			} 
			catch (error:SQLError) { 
				Alert.show("Error message:" + error.message+". Details:" + error.details); 
			} 		
		}
	}
}