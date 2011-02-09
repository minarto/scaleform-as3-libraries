package com.minarto.airApp.display
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.System;
	
	import com.minarto.events.DefaultEventDispatcher;
	
	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class AppLoader extends DefaultEventDispatcher
	{
		public var source:String;
		private var loader:Loader;
		
		
		
		/**
		 * 
		 * 
		 */		
		public function AppLoader()
		{
			super();
		}
		
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function load():void
		{
			destroy();
			
			loader = new Loader();
			var info:LoaderInfo = loader.contentLoaderInfo;
			info.addEventListener(Event.COMPLETE, hnComplete);
			loader.load(new URLRequest(source));
		}
		
		
		override public function destroy():void
		{
			super.destroy();
			
			if(loader)
			{
				try
				{
					loader.unload();
				}
				catch(error:Error)
				{
					
				}
				
				try
				{
					loader.unloadAndStop(true);
				}
				catch(error:Error)
				{
					
				}
				
				var info:LoaderInfo = loader.contentLoaderInfo;
				info.removeEventListener(Event.COMPLETE, hnComplete);
				
				loader = null;
			}
			
			System.gc();
		}
		
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		private function hnComplete($e:Event):void
		{
			var info:LoaderInfo = loader.contentLoaderInfo;
			info.removeEventListener(Event.COMPLETE, hnComplete);
			
			__content = info.content;
			
			dispatchEvent($e);
		}
		
		
		/**
		 * 
		 * @return 
		 * 
		 */
		private var __content:DisplayObject;
		public function get content():DisplayObject
		{
			return	__content;
		}
	}
}