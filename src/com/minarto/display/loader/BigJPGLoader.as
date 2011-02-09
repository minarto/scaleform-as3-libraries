package com.minarto.display.loader
{
	import flash.display.BitmapData;
	import flash.events.*;
	import flash.geom.Rectangle;
	import flash.net.*;
	
	import com.minarto.IDefaultInterface;
	
	import org.bytearray.decoder.JPEGDecoder;
	
	
	/**
	 * 
	 * @author UX
	 * 
	 */	
	public class BigJPGLoader extends URLLoader implements IDefaultInterface
	{
		private var decoder:JPEGDecoder;
		private var pixels:Vector.<uint>;
		
		
		private var __width:int;
		public function get width():int
		{
			return	__width;
		}
		
		
		private var __height:uint;
		public function get height():int
		{
			return	__height;
		}
		
		/**
		 * 
		 * @param $request
		 * 
		 */		
		public function BigJPGLoader($request:URLRequest=null)
		{
			dataFormat = URLLoaderDataFormat.BINARY;
			
			init();
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function init():void
		{
			decoder = new JPEGDecoder();
			addEventListener(Event.COMPLETE, complete);
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function destroy():void
		{
			close();
			
			removeEventListener(Event.COMPLETE, complete);
		}
		
		
		/**
		 * 
		 * @param $e
		 * 
		 */		
		private function complete($e:Event):void
		{
			decoder.parse(data);
			__width = decoder.width;
			__height = decoder.height;
			pixels = decoder.pixels;
			
			dispatchEvent($e);
		}
		
		
		/**
		 * 
		 * @param $rect
		 * @return 
		 * 
		 */			
		public function getBitmapData($rect:Rectangle):BitmapData
		{
			var w:uint = $rect.width;
			var h:uint = $rect.height;
			if(w > 8192 || h > 8192 || w * h > 16777216)	throw new Error("bitmapdata size Error");
			var bd:BitmapData = new BitmapData(w, h);
			if(!pixels)	return	bd;
			
			var addWidth:uint = width - w;
			var length:uint = pixels.length;
			
			var count:uint = width * $rect.y + $rect.x;
			var y:uint = 0;
			while(y < h)
			{
				var x:uint = 0;
				while(x < w)
				{
					bd.setPixel(x, y, pixels[count]);
					++ count;
					if(length <= count)	break;
					++ x;
				}
				count += addWidth;
				if(length <= count)	break;
				++ y;
			}
			
			return	bd;
		}
	}
}