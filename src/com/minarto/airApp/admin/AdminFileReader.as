package com.minarto.airApp.admin
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import com.minarto.events.DefaultEventDispatcher;
	
	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class AdminFileReader extends DefaultEventDispatcher
	{
		/**
		 * 
		 */		
		public var source:String;
		
		
		/**
		 * 
		 */		
		private var __data:String;
		public function get data():String
		{
			return	__data;
		}
		
		
		/**
		 * 
		 */		
		private var fileStream:FileStream;
		
		
		override public function destroy():void
		{
			if(fileStream)
			{
				fileStream.removeEventListener(Event.COMPLETE, hnComplete);
				fileStream.removeEventListener(IOErrorEvent.IO_ERROR, dispatchEvent);
				fileStream.removeEventListener(ProgressEvent.PROGRESS, dispatchEvent);
				fileStream.removeEventListener(Event.CLOSE, dispatchEvent);
				
				try
				{
					fileStream.close();
				}
				catch(error:Error)	{}
			}
			
			fileStream = null;
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function load():void
		{
			destroy();
			
			fileStream = new FileStream();
			
			fileStream.addEventListener(Event.COMPLETE, hnComplete);
			fileStream.addEventListener(IOErrorEvent.IO_ERROR, dispatchEvent);
			fileStream.addEventListener(ProgressEvent.PROGRESS, dispatchEvent);
			fileStream.addEventListener(Event.CLOSE, dispatchEvent);
			
			fileStream.openAsync(File.applicationDirectory.resolvePath(source), FileMode.READ);
		}
		
		
		/**
		 * 
		 * 
		 */		
		protected function hnComplete($e:Event):void
		{
			__data = fileStream.readUTFBytes(fileStream.bytesAvailable);
			destroy();
			dispatchEvent($e);
		}
	}
}