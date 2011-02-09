package com.minarto.comp.window
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import com.minarto.events.CompEventType;
	import com.minarto.comp.graphics.GraphicsContainer;
	
	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class WindowBase extends GraphicsContainer
	{
		/**
		 * 
		 */		
		private var __titleTxt:TextField;
		public function get titleTxt():TextField
		{
			return	__titleTxt;
		}
		
		
		/**
		 * 
		 */		
		public function set title($v:String):void
		{
			if(title == $v)	return;
			__titleTxt.text = $v || "";
			dispatchEvent(new Event(CompEventType.IN_RESIZE));
		}
		public function get title():String
		{
			return	__titleTxt.text;
		}
		
		
		/**
		 * 
		 */		
		private var __titleContainer:Sprite;
		public function get titleContainer():Sprite
		{
			return	__titleContainer;
		}
		
		
		/**
		 * 
		 */		
		private var __contentContainer:Sprite;
		public function get contentContainer():Sprite
		{
			return	__contentContainer;
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function WindowBase()
		{
			super();
			
			__contentContainer = new Sprite();
			__contentContainer.scrollRect = new Rectangle(0, 0, 0, 0);
			addChild(__contentContainer);
			
			
			__titleContainer = new Sprite();
			
			__titleTxt = new TextField();
			__titleTxt.autoSize = TextFieldAutoSize.LEFT;
			__titleContainer.addChild(__titleTxt);
			
			addChild(__titleContainer);
			
			addEventListener(CompEventType.IN_RESIZE, hnInReSize);
		}
		
		
		override public function destroy():void
		{
			super.destroy();
			removeEventListener(CompEventType.IN_RESIZE, hnInReSize);
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function exit():void
		{
			dispatchEvent(new Event(CompEventType.COMP_EXIT));
		}
		
		
		/**
		 * 
		 * 
		 */		
		protected function hnInReSize($e:Event):void
		{
			contentContainer.x = leftPadding;
			contentContainer.y = topPadding;
		}
	}
}