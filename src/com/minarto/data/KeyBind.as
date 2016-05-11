/**
 * 
 */
package com.minarto.data 
{
	import flash.display.Stage;
	import flash.events.*;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	
	import scaleform.clik.controls.*;
	import scaleform.clik.managers.FocusHandler;
	
	import scaleform.clik.core.CLIK;
	
	
	public class KeyBind extends Bind 
	{
		private var _instance:KeyBind = new KeyBind;
		
		
		static public function getInstance():KeyBind
		{
			return	_instance;
		}
		
		
		protected var keyMap:* = { }, _isEnable:Boolean, _lastKey:String, _isShift:Boolean, _isControl:Boolean, _isAlt:Boolean
		, checkEnterEvt:String;
	
	
		public var repeat:Boolean;
		

		public function KeyManager()
		{
			setEnable(true);
			
			checkEnterEvt = KeyboardEvent.KEY_UP + "." + Keyboard.ENTER + ".false.false.false";
		}
		
		
		public function setEnable($enable:Boolean):void
		{
			var stage:Stage;
			
			if ((_isEnable == $enable) && !(stage = CLIK.stage))
			{
				return;
			}
			
			_isEnable = $enable;
			if ($enable)
			{
				stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
				stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			}
			else
			{
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
				stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			}
		}
		

		public function getEnable():Boolean
		{
			return	_isEnable;
		}
		

		protected function onKeyDown ($e:KeyboardEvent):void
		{
			var f:* = FocusHandler.instance.getFocus(0), e:String;
			
			if (TextField(f) || TextInput(f) || TextArea(f))
			{
				return;
			}
			
			e = $e.type + "." + $e.keyCode + "." + $e.ctrlKey + "." + $e.altKey + "." + $e.shiftKey;
			if (!repeat && (_lastKey == e))
			{
				return;
			}
			
			if (f = keyMap[e])
			{
				evt(f, $e );
			}
			
			_lastKey = e;
		}
			
			
		private function onKeyUp ($e:KeyboardEvent):void
		{
			var f:* = FocusHandler.instance.getFocus(0), e:String = $e.type + "." + $e.keyCode + "." + $e.ctrlKey + "." + $e.altKey + "." + $e.shiftKey;
			
			_lastKey = null;
			if ((TextField(f) || TextInput(f) || TextArea(f)) && (e != checkEnterEvt))
			{
				return;	//	enter 예외
			}
			
			if (f = keyMap[e])
			{
				evt(f, $e );
			}
		}
		
		
		/**
		 * 키설정
		 * @param	$Bind
		 * @param	$type
		 * @param	$keyCode
		 * @param	$ctrlKey
		 * @param	$altKey
		 * @param	$shiftKey
		 */
		public function setKey($keyBind:String, $type:String, $keyCode:uint, $ctrlKey:Boolean, $altKey:Boolean, $shiftKey:Boolean):void
		{
			var e:String = arguments.slice(1).join(".");
			
			if ($keyBind)
			{
				keyMap[e] = $keyBind;
			}
			else
			{
				delete	keyMap[e];
			}
		}
		
		
		/**
		 * 
		 * @param	$BindKey
		 */
		public function delKey($keyBind:String):void
		{
			var e:String;
			
			for (e in keyMap)
			{
				if (keyMap[e] == $keyBind)
				{
					delete	keyMap[e];
				}
			}
		}
		
		
		public function getKey($keyBind:String):Array
		{
			var e:String, a:Array = [], a1:Array;
			
			for (e in keyMap)
			{
				if (keyMap[e] == $keyBind)
				{
					a1 = e.split(".");
					a.push({type:a1[0], keyCode:a1[1], ctrlKey:a1[2], altKey:a1[3], shiftKey:a1[4]});
				}
			}
			
			return	a;
		}
	}
}
