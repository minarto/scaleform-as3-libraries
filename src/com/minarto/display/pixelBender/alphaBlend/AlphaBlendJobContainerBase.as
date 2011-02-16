package com.minarto.display.pixelBender.alphaBlend
{
	
	import com.minarto.display.CustomSizeSprite;
	import com.minarto.display.pixelBender.colorConvert.ConvertColorJob;
	import com.minarto.events.CustomEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ShaderEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class AlphaBlendJobContainerBase extends CustomSizeSprite
	{
		/**
		 * 
		 */		
		protected var bitmapDatas:Vector.<BitmapItem> = Vector.<BitmapItem>([]);
		protected var bitmap:Bitmap;
		protected var bitmapData:BitmapData;
		protected var topBitmapData:BitmapData;
		protected var sourceRect:Rectangle;
		protected var desPoint:Point;
		
		protected var aBlendJob:AlphaBlendJob;
		
		
		override public function get numChildren():int
		{
			return	bitmapDatas.length;
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function AlphaBlendJobContainerBase()
		{
			sourceRect = new Rectangle(0, 0, 0, 0);
			desPoint = new Point(0, 0);
			super();
		}
		
		
		override public function init():void
		{
			addEventListener(Event.RESIZE, hnResize);
			
			bitmapDatas.length = 0;
			
			if(bitmapData)	bitmapData.dispose();
			bitmap = new Bitmap(bitmapData);
			addChildAt(bitmap, 0);
		}
		
		
		override public function destroy():void
		{
			removeEventListener(Event.RESIZE, hnResize);
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function clear():void
		{
			bitmapDatas.length = 0;
			bitmapData.dispose();
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function add($obj:DisplayObject):DisplayObject
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
			bitmapDatas.push(new BitmapItem($obj.x, $obj.y, bd, $obj));
			
			return	$obj;
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function addAt($obj:DisplayObject, $index:int):DisplayObject
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
			bitmapDatas.splice($index, 0, new BitmapItem($obj.x, $obj.y, bd, $obj));
			
			return	$obj;
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function getAt($index:int):DisplayObject
		{
			return	bitmapDatas[$index].sourceObject;
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function getIndex($obj:DisplayObject):int
		{
			var i:int = - 1;
			var length:uint = numChildren;
			var item:BitmapItem;
			while(++ i < length)
			{
				item = bitmapDatas[i];
				if(item.sourceObject == $obj)	break;
			}	
			
			return	i;
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function getName($name:String):DisplayObject
		{
			var i:int = - 1;
			var length:uint = numChildren;
			var item:BitmapItem;
			while(++ i < length)
			{
				item = bitmapDatas[i];
				if(item.sourceObject.name == $name)	break;
			}
			
			return	i < length ? item.sourceObject : null;
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function remove($obj:DisplayObject):DisplayObject
		{
			var i:int = - 1;
			var length:uint = numChildren;
			var item:BitmapItem;
			while(++ i < length)
			{
				item = bitmapDatas[i];
				if(item.sourceObject == $obj)
				{
					bitmapDatas.splice(i, 1);
					break;
				}
			}			
			
			return	$obj;
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function removeAt($index:uint):DisplayObject
		{
			var item:BitmapItem = bitmapDatas[$index];
			bitmapDatas.splice($index, 1);
			
			return	item.sourceObject;
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function draw():void
		{
			var i:int = - 1;
			var length:uint = numChildren;
			var bd:BitmapData;
			while(++ i < length)
			{
				drawIndex(i);
			}
		}
		
		
		/**
		 * 
		 * @param $e
		 * 
		 */		
		protected function drawIndex($index:uint):void
		{
			var item:BitmapItem = bitmapDatas[$index];
			
			var bd:BitmapData = item.bitmapData;
			sourceRect.width = bd.width;
			sourceRect.height = bd.height
			desPoint.x = item.x;
			desPoint.y = item.y;
			
			topBitmapData = new BitmapData(width, height, true, 0x00000000);
			topBitmapData.copyPixels(bd, sourceRect, desPoint);
			
			aBlendJob = new AlphaBlendJob(bitmapData, width, height);
			aBlendJob.bottomBitmapData = bitmapData;
			aBlendJob.topBitmapData = topBitmapData;
			aBlendJob.start(true);
		}
		
		
		/**
		 * 
		 * @param $e
		 * 
		 */		
		protected function hnResize($e:Event):void
		{
			if(bitmapData)
			{
				var bd:BitmapData = bitmapData.clone();
				bitmapData.dispose();
			}
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
			
			if(topBitmapData)	topBitmapData.dispose();
			topBitmapData = bitmapData.clone();
		}
	}
}