package com.minarto.display.pixelBender.alphaBlend
{
	
	import com.minarto.display.pixelBender.colorConvert.ConvertColorJob;
	
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
	public class AlphaBlendJobContainer extends AlphaBlendJobContainerBase
	{
		/**
		 * 
		 */		
		private var __eventBitmapData:BitmapData;
		public function get eventBitmapData():BitmapData
		{
			return	__eventBitmapData;
		}
		
		
		/**
		 * 
		 */		
		private var cBlendJob:ConvertColorJob;
		private var depthColor:uint = 0xFF000000;
		
		
		/**
		 * 
		 * 
		 */		
		public function AlphaBlendJobContainer()
		{
			super();
			
			mouseChildren = false;
		}
		
		
		override public function clear():void
		{
			depthColor = 0xFF000000;
			__eventBitmapData.dispose();
		}
		
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function getObject():DisplayObject
		{
			var color:uint = __eventBitmapData.getPixel32(mouseX, mouseY);
			var item:BitmapItem;
			var i:int = - 1;
			var length:uint = numChildren;
			while(++ i < length)
			{
				item = bitmapDatas[i];
				if(item.depthColor == color)	break;
			}
			
			return	(i < length) ? item.sourceObject : null;
		}
		
		
		override public function add($obj:DisplayObject):DisplayObject
		{
			super.add($obj);
			
			var item:BitmapItem = bitmapDatas[numChildren - 1];
			
			var bd:BitmapData = item.bitmapData.clone();
			cBlendJob = new ConvertColorJob(bd, bd.width, bd.height);
			cBlendJob.sourceBitmapData = item.bitmapData;
			item.depthColor = ++ depthColor;
			cBlendJob.color = depthColor;
			cBlendJob.start(true);
			item.eventBitmapData = bd;
			
			return	$obj;
		}
		
		
		override public function addAt($obj:DisplayObject, $index:int):DisplayObject
		{
			super.addAt($obj, $index);

			var item:BitmapItem = bitmapDatas[$index];
			
			var bd:BitmapData = item.bitmapData.clone();
			cBlendJob = new ConvertColorJob(bd, bd.width, bd.height);
			cBlendJob.sourceBitmapData = item.bitmapData;
			item.depthColor = ++ depthColor;
			cBlendJob.color = depthColor;
			cBlendJob.start(true);
			item.eventBitmapData = bd;
			
			return	$obj;
		}
		
		
		override public function remove($obj:DisplayObject):DisplayObject
		{
			var i:int = - 1;
			var length:uint = numChildren;
			var item:BitmapItem;
			while(++ i < length)
			{
				item = bitmapDatas[i];
				if(item.sourceObject == $obj)
				{
					item.bitmapData.dispose();
					item.eventBitmapData.dispose();
					
					bitmapDatas.splice(i, 1);
					break;
				}
			}			
			
			return	$obj;
		}
		
		
		override public function removeAt($index:uint):DisplayObject
		{
			var item:BitmapItem = bitmapDatas[$index];
			item.bitmapData.dispose();
			item.eventBitmapData.dispose();
			
			bitmapDatas.splice($index, 1);
			
			return	item.sourceObject;
		}
		
		
		override protected function drawIndex($index:uint):void
		{
			super.drawIndex($index);
			
			var item:BitmapItem = bitmapDatas[$index];
			
			var bd:BitmapData = item.eventBitmapData;
			sourceRect.width = bd.width;
			sourceRect.height = bd.height
			desPoint.x = item.x;
			desPoint.y = item.y;
			
			var sBitmapData:BitmapData = new BitmapData(width, height, true, 0x00000000);
			sBitmapData.copyPixels(bd, sourceRect, desPoint);
			
			aBlendJob = new AlphaBlendJob(__eventBitmapData, width, height);
			aBlendJob.bottomBitmapData = __eventBitmapData;
			aBlendJob.topBitmapData = sBitmapData;
			aBlendJob.start(true);
		}
		
		
		override protected function hnResize($e:Event):void
		{
			super.hnResize($e);
			__eventBitmapData = new BitmapData(width, height, false, 0xFFFFFFFF);
			var bm:Bitmap = new Bitmap(__eventBitmapData);
			bm.y = height;
			addChild(bm);
		}
	}
}