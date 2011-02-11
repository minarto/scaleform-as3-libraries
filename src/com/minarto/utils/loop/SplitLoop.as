package com.minarto.utils.loop
{
	import flash.display.Shape;
	import flash.events.Event;
	
	import com.minarto.events.CustomEvent;
	
	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class SplitLoop extends Shape
	{
		public var limit:uint = 500;
		private var count:uint;
		private var functions:Vector.<FunctionItem>;
		private var functionLength:uint;
		
		
		/**
		 * 
		 * 
		 */		
		public function SplitLoop()
		{
			functions = new Vector.<FunctionItem>();
		}
		
		
		/**
		 * 
		 * @param $function
		 * @param $args
		 * 
		 */		
		public function clear():void
		{
			count = 0;
			
			functions.fixed = false;
			functions.length = 0;
			functions.fixed = true;
			
			removeEventListener(Event.ENTER_FRAME, hnEnterFrame);
		}
		
		
		/**
		 * 
		 * @param $function
		 * @param $args
		 * 
		 */		
		public function clearFunction($functionItem:FunctionItem):void
		{
			functions.fixed = false;
			functions.splice(functions.indexOf($functionItem, 0), 1);
			functions.fixed = true;
			
			functionLength = functions.length;
			
			if(!functionLength)	removeEventListener(Event.ENTER_FRAME, hnEnterFrame);
		}
		
		
		/**
		 * 
		 * @param $function
		 * @param $args
		 * 
		 */		
		public function loop($limit:uint, $function:Function, ...$args):void
		{
			var item:FunctionItem = new FunctionItem();
			item.functionName = $function;
			item.arguements = $args;
			item.limit = $limit;
			
			functions.fixed = false;
			functions.push(item);
			functions.fixed = true;
			
			functionLength = functions.length;
			
			if(!hasEventListener(Event.ENTER_FRAME))	addEventListener(Event.ENTER_FRAME, hnEnterFrame);
		}
		
		
		/**
		 * 
		 * @param $e
		 * 
		 */			
		private function hnEnterFrame($e:Event):void
		{
			var i:int = - 1;
			var j:int;
			var item:FunctionItem;
			var iCount:uint;
			var arguements:Array;
			while(++ i < limit)
			{
				j = - 1;
				while(++ j < functionLength)
				{
					item = functions[j];
					iCount = item.count;
					if(iCount < item.limit)
					{
						arguements = item.arguements;
						if(arguements)
						{
							item.functionName.apply(null, arguements);
						}
						else
						{
							item.functionName();
						}
					}
					else
					{
						clearFunction(item);
						dispatchEvent(new CustomEvent(Event.COMPLETE, item.functionName));
						if(!functionLength)
						{
							break;
						}
						-- j;
					}
					if(!functionLength)
					{
						break;
					}
					item.count = iCount + 1;
				}
				
				if(!functionLength)
				{
					break;
				}
			}
		}
	}
}


final class FunctionItem
{
	public var functionName:Function;
	public var arguements:Array;
	public var limit:uint;
	public var count:uint;
}