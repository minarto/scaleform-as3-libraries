package com.minarto.filesystem
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import com.minarto.display.image.JPEGEncoder;
	import com.minarto.display.image.PNGEncoder;
	import com.minarto.events.DefaultEventDispatcher;
	
	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class ImageFileWrite extends DefaultEventDispatcher
	{
		private var fileStream:FileStream = new FileStream();

		
		/**
		 * 
		 * 
		 */		
		public function ImageFileWrite()
		{
			super();
		}
		
		
		override public function destroy():void
		{
			super.destroy();
			
			fileStream.removeEventListener(Event.COMPLETE, saveComplete);
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function saveImage($source:DisplayObject, $path:String, $name:String, $encodeType:String="jpg"):void
		{
			fileStream.close();
			
			var file:File = File.desktopDirectory.resolvePath($path + $name);
			fileStream.open(file, FileMode.WRITE);
			
			if($source as Bitmap)
			{
				var bd:BitmapData = ($source as Bitmap).bitmapData;
			}
			else
			{
				bd = new BitmapData($source.width, $source.height, false, 0xFFFFFF);
				bd.draw($source);
			}
			
			switch(($encodeType || "").toLowerCase())
			{
				case "png" :
					var ba:ByteArray = PNGEncoder.encode(bd);
					break;
				default :
					ba = (new JPEGEncoder(100)).encode(bd)
			}
			
			fileStream.writeBytes(ba);
			fileStream.close();
			
			fileStream.addEventListener(Event.COMPLETE, saveComplete);
			fileStream.openAsync(file, FileMode.READ);
		}
		
		
		/**
		 * 
		 * 
		 */		
		protected function saveComplete($e:Event):void
		{
			fileStream.removeEventListener(Event.COMPLETE, saveComplete);
			fileStream.close();
			dispatchEvent($e);
		}
	}
}