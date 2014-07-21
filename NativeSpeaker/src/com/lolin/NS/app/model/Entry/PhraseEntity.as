package com.lolin.NS.app.model.Entry
{
	import flash.data.SQLColumnSchema;
	import mx.controls.Alert;
		
	public final class PhraseEntity
	{
		private var id:int = -1;
		private var phrase:String = null;
		private var translation:String = null;
		private var date:Date = null;
		
		public function PhraseEntity(id:int, phrase:String, translation:String, date:Date){
			setID(id);
			setPhrase(phrase);
			setTranslation(translation);
			setDate(date);
		}
		
		public function getID():int{
			return this.id;
		}
		
		public function setID(id:int):void{
			this.id = id;
		}
		
		public function getPhrase():String{
			return this.phrase;
		}
		
		public function setPhrase(phrase:String):void{
			this.phrase = phrase;
		}
		
		public function getTranslation():String{
			return this.translation;
		}
		
		public function setTranslation(translation:String):void{
			this.translation = translation;
		}
		
		public function getDate():Date{
			return this.date;
		}
		
		public function setDate(date:Date):void{
			this.date = date;
		}
		
		public function show():void{
			Alert.show(this.phrase +"\n" + this.translation + "\n" + this.date.toTimeString());
		}
	}
	

}