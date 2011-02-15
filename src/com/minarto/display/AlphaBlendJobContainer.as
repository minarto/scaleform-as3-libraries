package com.minarto.display
{
	
	import com.minarto.display.pixelBender.alphaBlend.AlphaBlendJob;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class AlphaBlendJobContainer extends CustomSizeSprite
	{
		/**
		 * 
		 */		
		public var bitmapDatas:Vector.<BitmapItem> = Vector.<BitmapItem>([]);
		protected var bitmap:Bitmap;
		protected var bitmapData:BitmapData;
		protected var topBitmapData:BitmapData;
		protected var sourceRect:Rectangle;
		protected var desPoint:Point;
		protected var blendJob:AlphaBlendJob;
		
		
		/**
		 * 
		 * 
		 */		
		public function AlphaBlendJobContainer()
		{
			super();
		}
		
		
		override public function init():void
		{
			sourceRect = new Rectangle(0, 0, 0, 0);
			desPoint = new Point(0, 0);
			addEventListener(Event.RESIZE, hnResize);
			
			bitmapDatas.length = 0;
			
			if(bitmapData)	bitmapData.dispose();
			bitmap = new Bitmap(bitmapData);
			addChildAt(bitmap, 0);
			
			blendJob = new AlphaBlendJob(bitmapData, width, height);
		}
		
		
		override public function destroy():void
		{
			removeEventListener(Event.RESIZE, hnResize);
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function add($obj:DisplayObject):BitmapItem
		{
			var bd:BitmapData = new BitmapData($obj.width, $obj.height, true, 0x00000000);
			bd.draw($obj as DisplayObject);
			var item:BitmapItem = new BitmapItem($obj.x, $obj.y, bd);
			
			bitmapDatas.push(item);
			
			return	item;
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function addAt($obj:DisplayObject, $index:uint):BitmapItem
		{
			var bd:BitmapData = new BitmapData($obj.width, $obj.height, true, 0x00000000);
			bd.draw($obj as DisplayObject);
			var item:BitmapItem = new BitmapItem($obj.x, $obj.y, bd);
			
			bitmapDatas.splice($index, 0, item);
			
			return	item;
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function draw():void
		{
			var i:int = - 1;
			var length:uint = bitmapDatas.length;
			
			var item:BitmapItem;
				
			var bd:BitmapData;
			var w:int;
			var h:int;
			while(++ i < length)
			{
				item = bitmapDatas[i];
				bd = item.bitmapData;
				sourceRect.width = bd.width;
				sourceRect.height = bd.height
				desPoint.x = item.x;
				desPoint.y = item.y;
				
				topBitmapData.dispose();
				topBitmapData.copyPixels(bd, sourceRect, desPoint);
				
				blendJob.topBitmapData = topBitmapData;
				blendJob.start(false);
			}
		}
		
		
		/**
		 * 
		 * @param $e
		 * 
		 */		
		private function hnResize($e:Event):void
		{
			var bd:BitmapData = bitmapData;
			bitmapData = new BitmapData(width, height, true, 0x00000000);
			if(bd)
			{
				sourceRect.width = bd.width;
				sourceRect.height = bd.height;
				desPoint.x = 0;
				desPoint.y = 0;
				bitmapData.copyPixels(bd, sourceRect, desPoint);
				bd.dispose();
			}
			bitmap.bitmapData = bitmapData;
			
			topBitmapData = new BitmapData(width, height, true, 0x00000000);
			blendJob = new AlphaBlendJob(bitmapData, width, height);
			blendJob.bottomBitmapData = bitmapData;
		}
	}
}



import flash.display.BitmapData;

final class BitmapItem
{
	public var x:Number;
	public var y:Number;
	public var bitmapData:BitmapData;
	
	
	/**
	 * 
	 * @param $width
	 * @param $height
	 * @param $transparent
	 * @param $fillColor
	 * 
	 */	
	public function BitmapItem($x:Number, $y:Number, $bitmapData:BitmapData)
	{
		x = $x;
		y = $y;
		bitmapData = $bitmapData;
	}
}