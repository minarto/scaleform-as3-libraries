package com.minarto.web
{
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.html.HTMLLoader;
	import flash.net.URLRequest;
	
	import com.minarto.events.CustomEvent;
	import com.minarto.events.DefaultEventDispatcher;
	
	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class MultiTabBrowserManagerBase extends DefaultEventDispatcher
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
			dispatchEvent(new Event(WebBrowserEventType.CURRENT_TAB_PREV_CHANGE));
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
			return	__currentTab ? __currentTab.location : null;
		}
		
		
		/**
		 * 
		 */		
		public function historyBack():void
		{
			if(__currentTab)	__currentTab.historyBack();
		}
		
		
		/**
		 * 
		 */		
		public function historyForward():void
		{
			if(__currentTab)	__currentTab.historyForward();
		}
		
		
		/**
		 * 
		 */		
		public function reload():void
		{
			if(__currentTab)	__currentTab.reload();
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function MultiTabBrowserManagerBase()
		{
			super();
			
			__browserTabs = new Vector.<HTMLLoader>();
			
			__currentTab = new HTMLLoader();
			__browserTabs[0] = __currentTab;
			
			addEventListener(WebBrowserEventType.CURRENT_TAB_PREV_CHANGE, hnCurrentTabPrevChange);
			addEventListener(WebBrowserEventType.CURRENT_TAB_CHANGE, hnCurrentTabChange);
		}
		
		
		/**
		 * 
		 * @param $url
		 * 
		 */			
		protected function hnCurrentTabPrevChange($e:Event):void
		{
			__currentTab.removeEventListener(Event.COMPLETE, dispatchEvent);
			__currentTab.removeEventListener(Event.LOCATION_CHANGE, dispatchEvent);
			__currentTab.removeEventListener(WebBrowserEventType.BLANK_LOCATION_CHANGE, hnBlankLocationChange);
		}
		
		
		/**
		 * 
		 * @param $url
		 * 
		 */			
		protected function hnCurrentTabChange($e:Event):void
		{
			__currentTab.addEventListener(Event.COMPLETE, dispatchEvent);
			__currentTab.addEventListener(Event.LOCATION_CHANGE, dispatchEvent);
			__currentTab.addEventListener(WebBrowserEventType.BLANK_LOCATION_CHANGE, hnBlankLocationChange);
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
		public function newTab():void
		{
			currentTab = new HTMLLoader();
			currentTab.htmlHost = new CustomHost();
			__browserTabs.push(__currentTab);
		}
		
		
		/**
		 * 
		 * @param $url
		 * 
		 */
		protected function hnBlankLocationChange($e:CustomEvent):void
		{
			currentTab = $e.param as HTMLLoader;
			if(__browserTabs.indexOf(currentTab, 0) == - 1)	__browserTabs.push(__currentTab);
		}
	}
}