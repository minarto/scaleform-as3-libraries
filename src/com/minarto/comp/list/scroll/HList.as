package com.minarto.comp.list.scroll
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class HList extends ScrollListBase
	{
		override protected function hnEnterFrame($e:Event):void
		{
			if(!mouseChildren)	return;
			
			var rect:Rectangle = scrollRect;
			var _x:Number = rect.x - (mouseX - sx);
			
			var length:uint = dataProvider ? dataProvider.length : 0;
			if(length > 0)
			{
				var item:DisplayObject = dataProvider[length - 1];
				if(_x + rect.width > item.x + item.width)	_x = item.x + item.width - rect.width;
			}
			if(_x < 0)	_x = 0;
			rect.x = _x;
			
			scrollRect = rect;
		}
		
		
		override protected function hnScrollChange($e:Event):void
		{
			while(numChildren > 0)
			{
				removeChildAt(0);
			}
			
			var _x:Number = scrollRect.x;
			var _x2:Number;
			var w:Number = _x + scrollRect.width;
			var item:DisplayObject;
			var length:uint = dataProvider ? dataProvider.length : 0;
			var i:uint;
			while(i < length)
			{
				item = dataProvider[i];
				_x2 = item.x;
				if((_x2 < _x && _x2 + item.width > _x) || (_x2 >= _x && _x2 < w))	addChild(item);
				
				++ i;
			}
		}
		
		
		override protected function hnReSize($e:Event):void
		{
			super.hnReSize($e);
			
			var item:DisplayObject;
			var pitem:DisplayObject;
			var length:uint = dataProvider ? dataProvider.length : 0;
			var i:uint;
			while(i < length)
			{
				item = dataProvider[i];
				item.x = pitem ? pitem.x + pitem.width : 0;
				
				pitem = item;
				
				++ i;
			}
			
			__contentSize = item ? item.x + item.width : 0;
		}
		
		
		/**
		 * 
		 * 
		 */			
		public function left():Number
		{
			var rect:Rectangle = scrollRect;
			var _x:Number = rect.x;
			if(_x < 0)
			{
				_x = 0;
			}
			else
			{
				var length:uint = dataProvider ? dataProvider.length : 0;
				var i:int;
				var item:DisplayObject;
				while(i < length)
				{
					item = dataProvider[i];
					if(_x == item.x && i > 0)
					{
						item = dataProvider[i - 1];
						break;
					}
					else if(_x > item.x && _x < item.x + item.width)
					{
						break;
					}
					
					++ i;
				}
				
				_x = (i == length) ? _x : item.x;
			}
			
			return	_x;
		}
		
		
		/**
		 * 
		 * 
		 */			
		public function right():Number
		{
			var rect:Rectangle = scrollRect;
			var x:Number = rect.x + rect.height;
			
			var length:uint = dataProvider ? dataProvider.length : 0;
			var i:int;
			var item:DisplayObject;
			var w:Number;
			while(i < length)
			{
				item = dataProvider[i];
				w = item.height;
				if(x == item.x + w && i < length - 1)
				{
					item = dataProvider[i + 1];
					x = rect.x + (item.x + w - x);
					break;
				}
				else if(x > item.x && x < item.x + w)
				{
					x = rect.x + (item.x + w - x);
					break;
				}
				
				++ i;
			}
			if(length > 0)
			{
				item = dataProvider[length - 1];
				if(x + rect.width > item.x + item.width)	x = item.x + item.width - rect.width;
			}
			
			return x;
		}
	}
}