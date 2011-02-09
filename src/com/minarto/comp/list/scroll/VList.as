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
	public class VList extends ScrollListBase
	{
		override protected function hnEnterFrame($e:Event):void
		{
			if(!mouseChildren)	return;
			
			var rect:Rectangle = scrollRect;
			var _y:Number = rect.y - (mouseY - sy);
			
			var length:uint = dataProvider ? dataProvider.length : 0;
			if(length > 0)
			{
				var item:DisplayObject = dataProvider[length - 1];
				if(_y + rect.height > item.y + item.height)	_y = item.y + item.height - rect.height;
			}
			if(_y < 0)	_y = 0;
			rect.y = _y;
			
			scrollRect = rect;
		}
		
		
		override protected function hnScrollChange($e:Event):void
		{
			while(numChildren > 0)
			{
				removeChildAt(0);
			}
			
			var _y:Number = scrollRect.y;
			var _y2:Number;
			var h:Number = _y + scrollRect.height;
			var item:DisplayObject;
			var length:uint = dataProvider ? dataProvider.length : 0;
			var i:uint;
			while(i < length)
			{
				item = dataProvider[i];
				_y2 = item.y;
				if((_y2 < _y && _y2 + item.height > _y) || (_y2 >= _y && _y2 < h))	addChild(item);
				
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
				item.y = pitem ? pitem.y + pitem.height : 0;
				
				pitem = item;
				
				++ i;
			}
			
			__contentSize = item ? item.y + item.height : 0;
		}
		
		
		/**
		 * 
		 * 
		 */			
		public function up():Number
		{
			var rect:Rectangle = scrollRect;
			var _y:Number = rect.y;
			if(_y < 0)
			{
				_y = 0;
			}
			else
			{
				var length:uint = dataProvider ? dataProvider.length : 0;
				var i:int;
				var item:DisplayObject;
				while(i < length)
				{
					item = dataProvider[i];
					if(_y == item.y && i > 0)
					{
						item = dataProvider[i - 1];
						break;
					}
					else if(_y > item.y && _y < item.y + item.height)
					{
						break;
					}
					
					++ i;
				}
				
				_y = (i == length) ? _y : item.y;
			}
			
			return	_y;
		}
		
		
		/**
		 * 
		 * 
		 */			
		public function down():Number
		{
			var rect:Rectangle = scrollRect;
			var _y:Number = rect.y + rect.height;
			
			var length:uint = dataProvider ? dataProvider.length : 0;
			var i:int;
			var item:DisplayObject;
			var h:Number;
			while(i < length)
			{
				item = dataProvider[i];
				h = item.height;
				if(_y == item.y + h && i < length - 1)
				{
					item = dataProvider[i + 1];
					_y = rect.y + (item.y + h - _y);
					break;
				}
				else if(_y > item.y && _y < item.y + h)
				{
					_y = rect.y + (item.y + h - _y);
					break;
				}
				
				++ i;
			}
			if(length > 0)
			{
				item = dataProvider[length - 1];
				if(_y + rect.height > item.y + item.height)	_y = item.y + item.height - rect.height;
			}
			
			return _y;
		}
	}
}