package com.minarto.airApp.display
{
	import flash.events.Event;

	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class AppMain extends AppMainBase
	{
		/**
		 * 
		 */		
		protected var appLoader:AppLoader;
		
		
		/**
		 * 
		 * 
		 */		
		public function AppMain()
		{
			super();
			
			appLoader = new AppLoader();
		}
		
		
		override public function destroy():void
		{
			super.destroy();
			appLoader.destroy();
		}
		
		
		/**
		 * 
		 * @param $path
		 * 
		 */		
		protected function loadApp($path:String):void
		{
			appLoader.source = $path;
			appLoader.addEventListener(Event.COMPLETE, hnAppLoadComplete);
			appLoader.load();
		}
		
		
		/**
		 * 
		 * @param $e
		 * 
		 */		
		protected function hnAppLoadComplete($e:Event):void
		{
			appLoader.removeEventListener(Event.COMPLETE, hnAppLoadComplete);
			childApp = appLoader.content;
		}
	}
}