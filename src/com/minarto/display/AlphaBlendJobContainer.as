package com.minarto.display
{
	
	import com.minarto.display.pixelBender.alphaBlend.AlphaBlendJob;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.ShaderEvent;
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
		
		
		override public function get numChildren():int
		{
			return	bitmapDatas.length;
		}
		
		
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
			
			blendJob.removeEventListener(ShaderEvent.COMPLETE, hnShaderComplete);
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function add($obj:DisplayObject):BitmapItem
		{
			var bm:Bitmap = $obj as Bitmap;
			if(bm)
			{
				var bd:BitmapData = bm.bitmapData;
			}
			else
			{
				bd = new BitmapData($obj.width, $obj.height, true, 0x00000000);
				bd.draw($obj as DisplayObject);
			}
			var item:BitmapItem = new BitmapItem($obj.x, $obj.y, bd, $obj);
			
			bitmapDatas.push(item);
			
			return	item;
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function addAt($obj:DisplayObject, $index:uint):BitmapItem
		{
			var bm:Bitmap = $obj as Bitmap;
			if(bm)
			{
				var bd:BitmapData = bm.bitmapData;
			}
			else
			{
				bd = new BitmapData($obj.width, $obj.height, true, 0x00000000);
				bd.draw($obj as DisplayObject);
			}
			var item:BitmapItem = new BitmapItem($obj.x, $obj.y, bd, $obj);
			
			bitmapDatas.splice($index, 0, item);
			
			return	item;
		}
		
		private var count:int;
		/**
		 * 
		 * 
		 */		
		public function draw($waitForCompletion:Boolean=false):void
		{
			if($waitForCompletion)
			{
				count = 0;
				blendJob.addEventListener(ShaderEvent.COMPLETE, hnShaderComplete);
				drawIndex(count, true);
			}
			else
			{
				//blendJob.removeEventListener(ShaderEvent.COMPLETE, hnShaderComplete);
				count = - 1;
				var length:uint = numChildren;
				trace($waitForCompletion, length)
				var bd:BitmapData;
				while(++ count < length)
				{
					drawIndex(count, false);
				}
			}
		}
		
		
		/**
		 * 
		 * @param $e
		 * 
		 */		
		private function drawIndex($index:uint, $waitForCompletion:Boolean=false):void
		{
			var item:BitmapItem = bitmapDatas[$index];
			
			var bd:BitmapData = item.bitmapData;
			sourceRect.width = bd.width;
			sourceRect.height = bd.height
			desPoint.x = item.x;
			desPoint.y = item.y;
			
			topBitmapData = new BitmapData(width, height, true, 0x00000000);
			topBitmapData.copyPixels(bd, sourceRect, desPoint);
			
			blendJob = new AlphaBlendJob(bitmapData, width, height);
			blendJob.bottomBitmapData = bitmapData;
			blendJob.topBitmapData = topBitmapData;
			blendJob.start($waitForCompletion);
			trace($index)
		}
		
		
		/**
		 * 
		 * @param $e
		 * 
		 */		
		private function hnShaderComplete($e:ShaderEvent):void
		{
			trace($e)
			++ count;
			if(count < numChildren)
			{
				drawIndex(count, true);
			}
			else
			{
				dispatchEvent($e);
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
			
			blendJob.removeEventListener(ShaderEvent.COMPLETE, hnShaderComplete);
			blendJob = new AlphaBlendJob(bitmapData, width, height);
			blendJob.bottomBitmapData = bitmapData;
		}
	}
}



import flash.display.BitmapData;
import flash.display.DisplayObject;

final class BitmapItem
{
	public var x:Number;
	public var y:Number;
	public var bitmapData:BitmapData;
	public var sourceObject:DisplayObject;
	
	
	/**
	 * 
	 * @param $width
	 * @param $height
	 * @param $transparent
	 * @param $fillColor
	 * 
	 */	
	public function BitmapItem($x:Number, $y:Number, $bitmapData:BitmapData, $sourceObject:DisplayObject=null)
	{
		x = $x;
		y = $y;
		bitmapData = $bitmapData;
		sourceObject = $sourceObject;
	}
}