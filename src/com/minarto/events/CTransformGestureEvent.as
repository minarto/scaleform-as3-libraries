package com.minarto.events
{
	import flash.events.Event;

	public class CTransformGestureEvent extends CGestureEvent
	{
		private var __offsetX:Number = 0;
		public function get offsetX():Number
		{
			return	__offsetX;
		}
		
		
		private var __offsetY:Number = 0;
		public function get offsetY():Number
		{
			return	__offsetY;
		}
		
		
		private var __rotation:Number = 0;
		public function get rotation():Number
		{
			return	__rotation;
		}
		
		
		private var __scaleX:Number = 1;
		public function get scaleX():Number
		{
			return	__scaleX;
		}
		
		
		private var __scaleY:Number = 1;
		public function get scaleY():Number
		{
			return	__scaleY;
		}
		
		
		public function CTransformGestureEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, $phase:String=null, $localX:Number=0, $localY:Number=0, $scaleX:Number=1, $scaleY:Number=1, $rotation:Number=0, $offsetX:Number=0, $offsetY:Number=0, $ctrlKey:Boolean=false, $altKey:Boolean=false, $shiftKey:Boolean=false, $commandKey:Boolean=false, $controlKey:Boolean=false)
		{
			__scaleX = $scaleX;
			__scaleY = $scaleY;
			__rotation = $rotation;
			__offsetX = $offsetX;
			__offsetY = $offsetY;
			
			super(type, bubbles, cancelable, $phase, $localX, $localY, $ctrlKey, $altKey, $shiftKey, $commandKey, $controlKey);
		}
		
		
		override public function clone(): Event
		{
			return new CTransformGestureEvent(type, bubbles, cancelable, phase, localX, localY, scaleX, scaleY, rotation, offsetX, offsetY, ctrlKey, altKey, shiftKey, commandKey, controlKey);
		}
	}
}