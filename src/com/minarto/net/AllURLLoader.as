package com.minarto.net
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import com.minarto.IDefaultInterface;
	
	
	/**
	 */
	public final class AllURLLoader extends URLLoader implements IDefaultInterface
	{
		/**
		 * 
		 */		
		private var __charSet:String = "utf-8";
		public function get charSet():String
		{
			return	__charSet;
		}
		
		
		/**
		 */
		public function AllURLLoader(request:URLRequest=null, $charSet:String="utf-8")
		{
			init();
			__charSet = $charSet;
			
			super(request);
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function init():void
		{
			__charSet = "utf-8";
			dataFormat = URLLoaderDataFormat.BINARY;
			
			addEventListener(Event.COMPLETE, hnComplete);
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function destroy():void
		{
			removeEventListener(Event.COMPLETE, hnComplete);
			
			try
			{
				close();
			}
			catch($error:Error)	{}
		}
		
		
		override public function load(request:URLRequest):void
		{
			addEventListener(Event.COMPLETE, hnComplete);
			super.load(request);
		}
		
		
		/**
		 * 
		 * 
		 */		
		private function hnComplete($e:Event):void
		{
			var b:ByteArray = data;
			data = b.readMultiByte(b.bytesAvailable, __charSet);
		}
	}
}