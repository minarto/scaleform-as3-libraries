package com.minarto.web
{
	import flash.display.NativeWindow;
	import flash.events.Event;
	import flash.html.HTMLHost;
	import flash.html.HTMLLoader;
	import flash.html.HTMLWindowCreateOptions;
	
	import com.minarto.events.CustomEvent;
	
	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class CustomHost extends HTMLHost
	{
		/**
		 * 
		 * @param defaultBehaviors
		 * 
		 */		
		public function CustomHost(defaultBehaviors:Boolean=true)
		{
			super(defaultBehaviors);
		}
		
		
		override public function createWindow($windowCreateOptions:HTMLWindowCreateOptions):HTMLLoader
		{
			var hLoader:HTMLLoader = HTMLLoader.createRootWindow();
			hLoader.htmlHost = new CustomHost();
			hLoader.addEventListener(Event.LOCATION_CHANGE, updateLocation2);
			return	hLoader;
		}
		
		
		/**
		 * 
		 * @param $locationURL
		 * 
		 */		
		private function updateLocation2($e:Event):void
		{
			var hLoader:HTMLLoader = $e.target as HTMLLoader;
			hLoader.removeEventListener(Event.LOCATION_CHANGE, updateLocation2);
			htmlLoader.dispatchEvent(new CustomEvent(WebBrowserEventType.BLANK_LOCATION_CHANGE, hLoader));
		}
	}
}