package com.minarto.ui.virtualKeyboard
{
	import flash.display.DisplayObject;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import com.minarto.display.DefaultSprite;
	import com.minarto.events.CustomEvent;
	
	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class VirtualKeyboardBase extends DefaultSprite
	{
		protected var keyButtonList:Vector.<KeyButtonInfo> = new Vector.<KeyButtonInfo>();
		public var keyMode:String;
		public var language:String;
		
		
		override public function init():void
		{
			//addEventListener(MouseEvent.MOUSE_DOWN, hnKeyDown);
		}
		
		
		override public function destroy():void
		{
			removeEventListener(MouseEvent.MOUSE_DOWN, hnKeyDown);
		}
		
		
		/**
		 * 
		 * @param $e
		 * 
		 */		
		protected function hnKeyDown($e:MouseEvent):void
		{
			var _x:int = mouseX;
			var _y:int = mouseY;
			
			var btn:DisplayObject;
			var info:KeyButtonInfo;
			var length:uint = keyButtonList.length;
			var i:uint;
			while(i < length)
			{
				info = keyButtonList[i];
				btn = info.button;
				if(btn.x < _x && _x < btn.x + btn.width && btn.y < _y && _y < btn.y + btn.height)	break;
				
				++ i;
			}
			
			if(i < length)
			{
				switch(keyMode)
				{
					case VirtualKeyboardEventType.ALT_MODE_CHANGE :
						var str:String = info.altMode || info.defaultMode;
						break;
					case VirtualKeyboardEventType.SHIFT_MODE_CHANGE :
						str = info.shiftMode || info.defaultMode;
						break;
					default :
						str = info.defaultMode;
				}
				
				dispatchEvent(new CustomEvent(VirtualKeyboardEventType.KEY_DOWN, str));
			}
		}
	}
}