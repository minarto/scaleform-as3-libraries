package com.minarto.events
{
	import flash.events.EventDispatcher;
	
	import com.minarto.IDefaultInterface;
	
	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class DefaultEventDispatcher extends EventDispatcher implements IDefaultInterface
	{
		/**
		 * 
		 * 
		 */		
		public function DefaultEventDispatcher()
		{
			init();
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function init():void
		{
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function destroy():void
		{
		}
	}
}