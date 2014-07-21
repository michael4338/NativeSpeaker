package com.lolin.NS.app.control
{
	import com.lolin.NS.app.model.Entry.PhraseEntity;
	import com.lolin.NS.app.model.dao.NSDao;
	
	public class Writer
	{
		public function Writer()
		{
		}
		
		public function writePhraseToDB(phrase:String, translation:String=null):String{
			var dao:NSDao = new NSDao;
			var result:String = dao.insertPhrase(new PhraseEntity(0, phrase, translation, new Date));
			dao.close();	
			
			return result;
		}
		
		public function updatePhraseToDB(oldPhrase:String, newPhrase:String):String{
			var dao:NSDao = new NSDao;
			var result:String = dao.updatePhrase(oldPhrase, newPhrase);
			dao.close();
			
			return result;
		}
		
		public function deletePhraseFromDB(oldPhrase:String):String{
			var dao:NSDao = new NSDao;
			var result:String = dao.deletePhrase(oldPhrase);
			dao.close();
			
			return result;			
		}
	}
}