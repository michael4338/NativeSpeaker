package com.lolin.NS.app.model.NSDB
{
	import com.lolin.NS.app.model.NSCollection.NSConnection;
	
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.errors.SQLError;
	import flash.filesystem.File;
	import flash.net.URLRequest;
	
	import mx.controls.Alert;

	public class NSDB
	{
		public static const DBNAME:String = "NSDB.db";
		public static const DB:File = File.applicationStorageDirectory.resolvePath(DBNAME);
		public static const REMOTEDB_URL:String = "http://ascairauto.pac.adobe.com/AIR Updater/DB/NSDB.db";
		
		public function createDB():Boolean{
			if(DB.exists) return true;
			
			var conn:NSConnection = new NSConnection;			
			return initDB(conn);
		}
		
		public function downloadDB():Boolean{
			var file:File = new File;
			file.download(new URLRequest(REMOTEDB_URL));
			return true;
		}
		
		public function initDB(conn:NSConnection):Boolean{
			//create tables 
			
			var createStmt:SQLStatement = new SQLStatement(); 
			createStmt.sqlConnection = conn.getConnection(); 

			var sql:String =  
				"CREATE TABLE IF NOT EXISTS Phrase (" +  
				"    id INTEGER PRIMARY KEY AUTOINCREMENT, " +  
				"    phrase TEXT, " +  
				"    translation TEXT, " +  
				"    time DATE" +  
				")"; 
			createStmt.text = sql; 
			
			try{ 
				createStmt.execute(); 
				trace("Table created"); 
			} 
			catch (error:SQLError) { 
				Alert.show("Error message:" + error.message + ". Details:" + error.details); 
				return false;
			} 
						
			conn.closeConnection();
			return true;
		}

	}
}