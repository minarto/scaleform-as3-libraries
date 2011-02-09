package com.minarto.airApp.display
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import com.minarto.events.APPEventType;
	import com.minarto.display.DefaultSprite;
	
	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class AppContainer extends DefaultSprite
	{
		/**
		 * 
		 */		
		private var __childApp:DisplayObject
		public function set childApp($v:DisplayObject):void
		{
			if(childApp == $v)	return;
			dispatchEvent(new Event(APPEventType.APP_PREV_CHANGE));
			__childApp = $v;
			dispatchEvent(new Event(APPEventType.APP_CHANGE));
		}
		public function get childApp():DisplayObject
		{
			return	__childApp;
		}
		
		
		override public function init():void
		{
			addEventListener(APPEventType.APP_PREV_CHANGE, hnChildAppPrevChange);
			addEventListener(APPEventType.APP_CHANGE, hnChildAppChange);
		}
		
		
		override public function destroy():void
		{
			removeEventListener(APPEventType.APP_PREV_CHANGE, hnChildAppPrevChange);
			removeEventListener(APPEventType.APP_CHANGE, hnChildAppChange);
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function start():void
		{
		}
		
		
		/**
		 * 
		 * 
		 */		
		protected function hnChildAppPrevChange($e:Event=null):void
		{
			var childAppObj:Object = childApp;
			try
			{
				childAppObj.exit();
			}
			catch(error:Error)	{}
		}
		
		
		/**
		 * 
		 * 
		 */		
		protected function hnChildAppExit($e:Event):void
		{
		}
		
		
		/**
		 * 
		 * 
		 */		
		protected function hnChildAppChange($e:Event):void
		{
			if(childApp)
			{
				var childAppObj:Object = childApp;
				try
				{
					childAppObj.start();
				}
				catch(error:Error)	{}
			}
		}
	}
}