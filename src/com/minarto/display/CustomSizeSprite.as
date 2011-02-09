package com.minarto.display
{
	import flash.events.Event;
	
	
	/**
	 * 
	 * @author UX
	 * 
	 */	
	public class CustomSizeSprite extends DefaultSprite
	{
		private var __width:int;
		override public function set width($v:Number):void
		{
			if($v == width)	return;
			__width = $v;
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
			__height = $v;
			dispatchEvent(new Event(Event.RESIZE));
		}
		override public function get height():Number
		{
			return	__height;
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
	}
}