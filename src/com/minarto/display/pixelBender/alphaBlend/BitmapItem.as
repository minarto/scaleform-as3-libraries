package com.minarto.display.pixelBender.alphaBlend
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;

	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class BitmapItem
	{
		public var x:Number;
		public var y:Number;
		public var bitmapData:BitmapData;
		public var eventBitmapData:BitmapData;
		public var sourceObject:DisplayObject;
		public var depthColor:uint;
		
		
		/**
		 * 
		 * @param $width
		 * @param $height
		 * @param $transparent
		 * @param $fillColor
		 * 
		 */	
		public function BitmapItem($x:Number, $y:Number, $bitmapData:BitmapData, $sourceObject:DisplayObject=null, $eventBitmapData:BitmapData=null)
		{
			x = $x;
			y = $y;
			bitmapData = $bitmapData;
			sourceObject = $sourceObject;
			eventBitmapData = $eventBitmapData;
		}
	}
}