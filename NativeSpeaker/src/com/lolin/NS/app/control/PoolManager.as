package com.lolin.NS.app.control
{
	import com.lolin.NS.app.model.Entry.PhraseEntity;
	import com.lolin.NS.app.model.dao.NSDao;
	import com.lolin.NS.app.view.NSTextContainer;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class PoolManager
	{
		private const MAX_COUNT:int = 100;
		private const MIN_COUNT:int = 5;
		
		private var interval:int = 10;
		private var poolArray:Array = new Array;
		
		private var timer:Timer = null;
		private var bPause:Boolean = false;
		private var bLock:Boolean = false;
	
		private var textContainer:NSTextContainer = null;
		
		private var incremental:int = 0;
		public static var serialPool:Boolean = true;
		
		public function PoolManager(text:NSTextContainer){
			this.textContainer = text;
			text.poolManager = this;
		}
		
		public function start():void{
			fetch();
			timer = new Timer(interval*1000, 0);
			timer.addEventListener(TimerEvent.TIMER, feed);
			timer.start();
		}
		
		public function resume(rightnow:Boolean=false):void{
			this.bPause = false;
			if(rightnow) this.show();
		}
		
		public function pause():void{
			this.bPause = true;
			this.bLock = bLock;
		}
		
		public function unLock():void{
			this.bLock = false;
		}
		
		public function lock():void{
			this.bLock = true;
		}
		
		public function stop():void{
			timer.stop();
		}
		
		private function show():void{
			if(poolArray.length == 0 || this.bPause || this.bLock) return;
			
			var currentEntity:PhraseEntity = poolArray.shift() as PhraseEntity;
			var id:int = currentEntity.getID();
			var phrase:String = currentEntity.getPhrase();
			this.textContainer.show(phrase, id);			
		}
		
		private function feed(e:TimerEvent):void{
			if(this.bPause) return;
			
			if(poolArray.length == 0) return fetch();
			
			this.show();
			
			if(poolArray.length == MIN_COUNT) fetch();
		}
		
		private function fetch():void{
			var dao:NSDao = new NSDao;
			
			var endIndex:int = (poolArray.length ==0) ? (-1) : (poolArray.length -1);
			var id:int = (endIndex < 0) ? (-1) : ((poolArray[endIndex] as PhraseEntity).getID());
			
			if(PoolManager.serialPool){
				trace("Using Serial way");
				poolArray = poolArray.concat(dao.getPhraseList(id, this.MAX_COUNT));
			}
			else{
				trace("Using Random way");
				poolArray = poolArray.concat(dao.getRandomPhraseList(this.MAX_COUNT));
			}
			
			trace("fetch new, " + poolArray.length);
			
			dao.close();		
		}
	}
}