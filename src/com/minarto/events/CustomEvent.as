package com.minarto.events
{
	import flash.events.Event;


	/**
	 */
	public class CustomEvent extends Event
	{
		/**
		 * 인수
		 */		
		private var __param:Object;
		public function get param():Object
		{
			return	__param;
		}
		
		
		/**
		 * 
		 * @param $type
		 * @param $param
		 * @param $bubbles
		 * @param $cancelable
		 * 
		 */					
		public function CustomEvent($type:String, $param:Object=null, $bubbles:Boolean=false, $cancelable:Boolean=false)
		{
			__param = $param;
			
			super($type, $bubbles, $cancelable);
		}
		
		
		override public function clone(): Event
		{
			return new CustomEvent(type, __param, bubbles, cancelable);
		}
	}
}