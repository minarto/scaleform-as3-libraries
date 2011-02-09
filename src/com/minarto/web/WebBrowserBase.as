package com.minarto.web
{
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.html.HTMLLoader;
	import flash.net.URLRequest;
	
	import com.minarto.display.CustomSizeSprite;
	
	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class WebBrowserBase extends CustomSizeSprite
	{
		/**
		 * 
		 */		
		private var __browserTabs:Vector.<HTMLLoader>;
		public function get browserTabs():Vector.<HTMLLoader>
		{
			return	__browserTabs;
		}
		
		
		
		/**
		 * 
		 */		
		private var __popUps:Vector.<HTMLLoader>;
		public function get popUps():Vector.<HTMLLoader>
		{
			return	__popUps;
		}
		
		
		/**
		 * 
		 */		
		private var __currentTab:HTMLLoader;
		public function set currentTab($v:HTMLLoader):void
		{
			if($v == currentTab)	return;
			__currentTab = $v;
			dispatchEvent(new Event(WebBrowserEventType.CURRENT_TAB_CHANGE));
		}
		public function get currentTab():HTMLLoader
		{
			return	__currentTab;
		}
		
		
		/**
		 * 
		 */		
		public function get location():String
		{
			return	__currentTab.location;
		}
		
		
		/**
		 * 
		 */		
		public function historyBack():void
		{
			__currentTab.historyBack();
		}
		
		
		/**
		 * 
		 */		
		public function historyForward():void
		{
			__currentTab.historyForward();
		}
		
		
		/**
		 * 
		 */		
		public function reload():void
		{
			__currentTab.reload();
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function WebBrowserBase()
		{
			scrollRect = new Rectangle(0, 0, 0, 0);
			
			__browserTabs = new Vector.<HTMLLoader>();
			
			__currentTab = new HTMLLoader();
			__browserTabs[0] = __currentTab;
			addChild(__currentTab);
			
			addEventListener(Event.RESIZE, hnReSize);
		}
		
		
		override public function destroy():void
		{
			removeEventListener(Event.RESIZE, hnReSize);
		}
		
		
		/**
		 * 
		 * @param $e
		 * 
		 */		
		protected function hnReSize($e:Event):void
		{
			var rect:Rectangle = scrollRect;
			rect.width = width;
			rect.height = height;
			scrollRect = rect;
			
			__currentTab.width = width;
			__currentTab.height = height;
		}
		
		
		/**
		 * 
		 * @param $url
		 * 
		 */			
		public function load($url:String):void
		{
			__currentTab.addEventListener(Event.COMPLETE, dispatchEvent);
			__currentTab.addEventListener(Event.LOCATION_CHANGE, dispatchEvent);
			__currentTab.addEventListener(WebBrowserEventType.BLANK_LOCATION_CHANGE, hnBlankLocationChange);
			__currentTab.htmlHost = new CustomHost();
			__currentTab.load(new URLRequest($url));
		}
		
		
		/**
		 * 
		 * @param $url
		 * 
		 */
		public function newTab($url:String):void
		{
			__currentTab.removeEventListener(Event.COMPLETE, dispatchEvent);
			__currentTab.removeEventListener(Event.LOCATION_CHANGE, dispatchEvent);
			removeChild(__currentTab);
			
			__currentTab = new HTMLLoader();
			__currentTab.addEventListener(Event.COMPLETE, dispatchEvent);
			__browserTabs.push(__currentTab);
			addChild(__currentTab);
		}
		
		
		/**
		 * 
		 * @param $url
		 * 
		 */
		private function hnBlankLocationChange($e:Event):void
		{
			
		}
	}
}