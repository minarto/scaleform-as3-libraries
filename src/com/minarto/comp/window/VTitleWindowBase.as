package com.minarto.comp.window
{
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.TextFieldAutoSize;
	
	import com.minarto.events.CompEventType;
	
	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class VTitleWindowBase extends WindowBase
	{
		override public function set title($v:String):void
		{
			super.title = $v;
			titleTxt.autoSize = TextFieldAutoSize.LEFT;
			titleTxt.autoSize = TextFieldAutoSize.NONE;
			titleTxt.width = width - leftPadding - rightPadding;
			
			contentContainer.y = titleTxt.height + topPadding;
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function VTitleWindowBase()
		{
			super();
		}
		
		
		override protected function hnReSize($e:Event):void
		{
			super.hnReSize($e);
			
			titleTxt.autoSize = TextFieldAutoSize.NONE;
			titleTxt.width = width - leftPadding - rightPadding;
			
			dispatchEvent(new Event(CompEventType.IN_RESIZE));
		}
		
		
		override protected function hnInReSize($e:Event):void
		{
			super.hnInReSize($e);
			
			var rect:Rectangle = contentContainer.scrollRect;
			rect.x = leftPadding;
			rect.y = topPadding;
			rect.width = width - leftPadding - rightPadding;
			rect.height = height - titleTxt.height - topPadding - bottomPadding;
			contentContainer.scrollRect = rect;
			
			titleTxt.x = leftPadding;
			
			contentContainer.x = leftPadding;
			contentContainer.y = titleTxt.height + topPadding;
		}
	}
}