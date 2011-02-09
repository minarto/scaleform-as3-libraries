package com.minarto.ui.virtualKeyboard
{
	import flash.events.Event;
	import flash.text.TextField;
	
	import com.minarto.events.CustomEvent;
	import com.minarto.events.DefaultEventDispatcher;
	
	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class VirtualKeyboardInputManager extends DefaultEventDispatcher
	{
		public var textField:TextField;
		
		
		override public function init():void
		{
			addEventListener(VirtualKeyboardEventType.KEY_DOWN, hnKeyDown);
		}
		
		
		override public function destroy():void
		{
			super.destroy();
			
			removeEventListener(VirtualKeyboardEventType.KEY_DOWN, hnKeyDown);
		}
		
		
		/**
		 * 
		 * 
		 */		
		protected function hnKeyDown($e:CustomEvent):void
		{
			if(!textField)	return;
			
			if(textField.stage)	textField.stage.focus = textField;
			
			var str:String = String($e.param);
			switch(str)
			{
				case VirtualKeyboardEventType.TAB : 
					break;
				
				case VirtualKeyboardEventType.ENTER :
					break;
				
				case VirtualKeyboardEventType.BACKSPACE :
					var index:int = textField.selectionEndIndex;
					var text:String = textField.text;
					textField.text = text.substr(0, index - 1) + text.substr(index, text.length);
					textField.setSelection(index - 1, index - 1);
					break;
				
				default :
					index = textField.selectionEndIndex;
					text = textField.text;
					textField.text = text.substr(0, index) + str + text.substr(index, text.length);
					textField.setSelection(index + str.length, index + str.length);
			}
		}
	}
}