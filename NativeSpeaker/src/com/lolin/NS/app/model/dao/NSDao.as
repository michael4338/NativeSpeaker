package com.lolin.NS.app.model.dao
{
	import com.lolin.NS.app.model.Entry.*;
	import com.lolin.NS.app.model.NSCollection.NSConnection;
	import com.lolin.NS.app.view.NSTextContainer;
	
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.errors.SQLError;
	
	import mx.collections.ArrayList;
	
	public class NSDao
	{
		private var _conn:NSConnection = null;
		
		private static var firstTime:Boolean = true;
		private static var initialArrayList:ArrayList = null;
		
		public function NSDao()
		{
			if(_conn == null) _conn = new NSConnection;
		}
		
		public function close():void{
			if(_conn != null) {
				_conn.closeConnection();
				_conn = null;
			}
		}
		
		public function insertPhrase(entity:PhraseEntity):String{
			
			var selectStmt:SQLStatement = new SQLStatement();
			selectStmt.sqlConnection = _conn.getConnection();
			selectStmt.text = "SELECT phrase FROM Phrase P where P.phrase=:phrase"; 
			selectStmt.parameters[":phrase"] = entity.getPhrase();
			try{
				selectStmt.execute(); 
				var result:SQLResult = selectStmt.getResult(); 
				if(result != null){
					if(result.data != null){
						if(result.data.length > 0){
							trace("result existed, "+entity.getPhrase());
							return NSTextContainer.RETURN_TYPE_EXISTED;
						}
					}
				}
			}catch(error:SQLError){
				return NSTextContainer.RETURN_TYPE_DBERROR;
			}
			
			
			var sql:String =  
				"INSERT INTO Phrase (phrase, translation, time)" + 
				"VALUES (:phrase, :translation, :time)"; 
			
			var addItemStmt:SQLStatement = new SQLStatement(); 
			addItemStmt.sqlConnection = _conn.getConnection(); 
			addItemStmt.text = sql; 

			addItemStmt.parameters[":phrase"] = entity.getPhrase(); 
			addItemStmt.parameters[":translation"] = entity.getTranslation();
			addItemStmt.parameters[":time"] = entity.getDate();
			
			
			try{
				addItemStmt.execute();
			}catch(error:SQLError) { 
				return NSTextContainer.RETURN_TYPE_DBERROR;
			}
			
			return NSTextContainer.RETURN_TYPE_SUCCESS;
			
		}
		
		public function getRandomPhraseList(num:int):Array{
			var phraseEntityArray:Array = new Array;
			
			if(NSDao.firstTime){
				//copy all the things in DB to initialArray
				var arr:Array = getPhraseList(0, 99999);
				NSDao.initialArrayList = new ArrayList(arr);
				NSDao.firstTime = false;
			}else{
				//get random data
				var count:int = 0;
				while(count < num && NSDao.initialArrayList.length > 0){
					var randomIndex:int = Math.floor( Math.random() * NSDao.initialArrayList.length);
					phraseEntityArray.push(NSDao.initialArrayList.removeItemAt(randomIndex) as PhraseEntity);
					count ++;
				}
				if(count < num){
					NSDao.firstTime = true;
				}
			}
			
			return phraseEntityArray;
		}
		
		public function getPhraseList(id:int, num:int):Array{
			var selectStmt:SQLStatement = new SQLStatement(); 
			
			selectStmt.sqlConnection = _conn.getConnection();
			selectStmt.text = "SELECT id, phrase, translation, time FROM Phrase P where P.id>:id"; 
			selectStmt.parameters[":id"] = id;
			
			var phraseEntityArray:Array = new Array;
			try { 
				selectStmt.execute(); 
				var result:SQLResult = selectStmt.getResult(); 
				
				if(result != null){
					if(result.data != null){
						var numResults:int = result.data.length; 
						for (var i:int = 0; i < numResults && i<num; i++) { 
							var row:Object = result.data[i]; 
						
							var id:int = int(row.id);
							var phrase:String = row.phrase as String;
							var translation:String = row.translation as String;
							var time:Date = row.time as Date;
						
							phraseEntityArray.push(new PhraseEntity(id, phrase, translation, time));
						}
					} 
				}

			} 
			catch (error:SQLError) { 
				trace("query Phrase failed, "+ error.message);
			}
			
			return phraseEntityArray;
		}
		
		
		public function updatePhrase(oldPhrase:String, newPhrase:String):String{

			var updateStmt:SQLStatement = new SQLStatement(); 
			
			updateStmt.sqlConnection = _conn.getConnection();
			updateStmt.text = "UPDATE Phrase SET phrase=:newphrase where phrase=:oldphrase"; 
			updateStmt.parameters[":newphrase"] = newPhrase;
			updateStmt.parameters[":oldphrase"] = oldPhrase;
			
			try { 
				updateStmt.execute(); 
				var result:SQLResult = updateStmt.getResult(); 
				if(result != null)
					if(result.rowsAffected > 0)
						return NSTextContainer.RETURN_TYPE_SUCCESS;
			} 
			catch (error:SQLError) { 
				trace("update Phrase failed, "+ error.message +". Details: "+error.details);
			}
			
			return NSTextContainer.RETURN_TYPE_DBERROR;
		}

		public function deletePhrase(oldPhrase:String):String{
			var deleteStmt:SQLStatement = new SQLStatement(); 
			
			deleteStmt.sqlConnection = _conn.getConnection();
			deleteStmt.text = "DELETE FROM Phrase where phrase=:oldphrase"; 
			deleteStmt.parameters[":oldphrase"] = oldPhrase;
			
			try { 
				deleteStmt.execute(); 
				var result:SQLResult = deleteStmt.getResult(); 
				if(result != null)
					if(result.rowsAffected > 0)
						return NSTextContainer.RETURN_TYPE_SUCCESS;
			} 
			catch (error:SQLError) { 
				trace("delete Phrase failed, "+ error.message +". Details: "+error.details);
			}
			
			return NSTextContainer.RETURN_TYPE_DBERROR;
		}
		
		
	}
}


