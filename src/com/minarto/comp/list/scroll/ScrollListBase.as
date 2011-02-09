package com.minarto.comp.list.scroll
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import com.minarto.events.CompEventType;
	import com.minarto.comp.list.ListBase;
	
	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class ScrollListBase extends ListBase
	{
		private var __width:int;
		override public function set width($v:Number):void
		{
			if($v == width)	return;
			__width = $v || 0;
			dispatchEvent(new Event(Event.RESIZE));
		}
		override public function get width():Number
		{
			return	__width;
		}
		
		
		private var __height:int;
		override public function set height($v:Number):void
		{
			if($v == height)	return;
			__height = $v || 0;
			dispatchEvent(new Event(Event.RESIZE));
		}
		override public function get height():Number
		{
			return	__height;
		}
		
		
		override public function set scrollRect($rectangle:Rectangle):void
		{
			if(scrollRect.x != $rectangle.x || scrollRect.y != $rectangle.y || scrollRect.width != $rectangle.width || scrollRect.height != $rectangle.height)
			{
				super.scrollRect = $rectangle;
				dispatchEvent(new Event(CompEventType.SCROLL_CHANGE));
			}
		}
		
		
		/**
		 * 사이즈 설정 
		 * @param $w
		 * @param $h
		 * 
		 */		
		public function setSize($w:int, $h:int):void
		{
			if($w == width && $h == height)	return;
			__width = $w;
			__height = $h;
			dispatchEvent(new Event(Event.RESIZE));
		}
		
		
		/**
		 *	생성자 
		 * 
		 */		
		public function ScrollListBase()
		{
			super();
			
			super.scrollRect = new Rectangle(0, 0, 0, 0);
			
			addEventListener(Event.RESIZE, hnReSize);
			addEventListener(CompEventType.SCROLL_CHANGE, hnScrollChange);
		}
		
		
		override public function destroy():void
		{
			super.destroy();
			removeEventListener(Event.RESIZE, hnReSize);
			removeEventListener(Event.ENTER_FRAME, hnEnterFrame);
			removeEventListener(CompEventType.SCROLL_CHANGE, hnScrollChange);
		}
		
		
		override protected function hnDataChange($e:Event):void
		{
			super.hnDataChange($e);
			
			hnScrollChange(null);
		}
		
		
		/**
		 * 
		 * @param $e
		 * 
		 */		
		protected function hnScrollChange($e:Event):void
		{
		}
		
		
		override protected function hnDown($e:MouseEvent):void
		{
			super.hnDown($e);
			addEventListener(Event.ENTER_FRAME, hnEnterFrame);
		}
		
		
		/**
		 * 
		 * @param $e
		 * 
		 */			
		protected function hnEnterFrame($e:Event):void
		{
		}
		
		
		override protected function hnUp($e:MouseEvent):void
		{
			super.hnUp($e);
			removeEventListener(Event.ENTER_FRAME, hnEnterFrame);
		}
		
		
		override protected function hnReSize($e:Event):void
		{
			var rect:Rectangle = scrollRect;
			rect.width = width;
			rect.height = height;
			scrollRect = rect;
			
			graphics.clear();
			graphics.beginFill(0xFFFFFF, 0);
			graphics.drawRect(0, 0, width, height);
		}
		
		
		/**
		 * 
		 */		
		protected var __contentSize:Number;
		public function get contentSize():Number
		{
			return	__contentSize;
		}
		
		
		override public function addItem($obj:DisplayObject):DisplayObject
		{
			super.addItem($obj);
			hnScrollChange(null);
			
			return	$obj;
		}
		
		
		override public function addItemAt($obj:DisplayObject, $index:uint):DisplayObject
		{
			super.addItemAt($obj, $index);
			hnScrollChange(null);
			
			return	$obj;
		}
		
		
		override public function removeItem($obj:DisplayObject):DisplayObject
		{
			super.removeItem($obj);
			hnScrollChange(null);
			
			return	$obj;
		}
		
		
		override public function removeItemIndex($index:uint):DisplayObject
		{
			var _obj:DisplayObject = super.removeItemIndex($index);
			hnScrollChange(null);
			
			return	_obj;
		}
	}
}