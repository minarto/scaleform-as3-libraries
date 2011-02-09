package com.minarto.events
{
	import flash.events.Event;
	
	public class CGestureEvent extends Event
	{
		private var __phase:String;
		public function get phase():String
		{
			return	__phase;
		}
		
		
		private var __localX:Number = 0;
		public function get localX():Number
		{
			return	__localX;
		}
		
		
		private var __localY:Number = 0;
		public function get localY():Number
		{
			return	__localY;
		}
		
		
		private var __ctrlKey:Boolean;
		public function get ctrlKey():Boolean
		{
			return	__ctrlKey;
		}
		
		
		private var __altKey:Boolean;
		public function get altKey():Boolean
		{
			return	__altKey;
		}
		
		
		private var __shiftKey:Boolean;
		public function get shiftKey():Boolean
		{
			return	__shiftKey;
		}
		
		
		private var __commandKey:Boolean;
		public function get commandKey():Boolean
		{
			return	__commandKey;
		}
		
		
		private var __controlKey:Boolean;
		public function get controlKey():Boolean
		{
			return	__controlKey;
		}
		
		
		/**
		 * 
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 * @param $phase
		 * @param $localX
		 * @param $localY
		 * @param $ctrlKey
		 * @param $altKey
		 * @param $shiftKey
		 * @param $commandKey
		 * @param $controlKey
		 * 
		 */		
		public function CGestureEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, $phase:String=null, $localX:Number=0, $localY:Number=0, $ctrlKey:Boolean=false, $altKey:Boolean=false, $shiftKey:Boolean=false, $commandKey:Boolean=false, $controlKey:Boolean=false)
		{
			__phase = $phase;
			__localX = $localX;
			__localY = $localY;
			__ctrlKey = $ctrlKey;
			__altKey = $altKey;
			__shiftKey = $shiftKey;
			__commandKey = $commandKey;
			__controlKey = $controlKey;
			
			super(type, bubbles, cancelable);
		}
		
		
		override public function clone(): Event
		{
			return new CGestureEvent(type, bubbles, cancelable, __phase, __localX, __localY, __ctrlKey, __altKey, __shiftKey, __commandKey, __controlKey);
		}
	}
}