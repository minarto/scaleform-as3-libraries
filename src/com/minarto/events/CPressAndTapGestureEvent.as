package com.minarto.events
{
	import flash.events.Event;

	public class CPressAndTapGestureEvent extends CGestureEvent
	{
		private var __tapLocalX:Number = 0;
		public function get tapLocalX():Number
		{
			return	__tapLocalX;
		}
		
		
		private var __tapLocalY:Number = 0;
		public function get tapLocalY():Number
		{
			return	__tapLocalY;
		}
		
		
		private var __tapStageX:Number = 0;
		public function get tapStageX():Number
		{
			return	__tapStageX;
		}
		
		
		private var __tapStageY:Number = 0;
		public function get tapStageY():Number
		{
			return	__tapStageY;
		}
		
		
		public function CPressAndTapGestureEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, $phase:String=null, $localX:Number=0, $localY:Number=0, $tapLocalX:Number=0, $tapLocalY:Number=0, $tapStageX:Number=0, $tapStageY:Number=0, $ctrlKey:Boolean=false, $altKey:Boolean=false, $shiftKey:Boolean=false, $commandKey:Boolean=false, $controlKey:Boolean=false)
		{
			__tapLocalX = $tapLocalX;
			__tapLocalY = $tapLocalY;
			__tapStageX = $tapStageX;
			__tapStageY = $tapStageY;

			super(type, bubbles, cancelable, $phase, $localX, $localY, $ctrlKey, $altKey, $shiftKey, $commandKey, $controlKey);
		}
		
		
		override public function clone(): Event
		{
			return new CPressAndTapGestureEvent(type, bubbles, cancelable, phase, localX, localY, tapLocalX, tapLocalY, tapStageX, tapStageY, ctrlKey, altKey, shiftKey, commandKey, controlKey);
		}
	}
}