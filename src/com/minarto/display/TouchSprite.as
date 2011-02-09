package com.minarto.display
{
	import flash.events.Event;
	import flash.events.TouchEvent;
	import flash.events.TransformGestureEvent;
	
	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class TouchSprite extends DefaultSprite
	{
		/**
		 * 
		 */		
		private var firstTouchList:Vector.<TouchEvent> = new Vector.<TouchEvent>();
		private var lastTouchList:Vector.<TouchEvent> = new Vector.<TouchEvent>();
		
		
		override public function init():void
		{
			addEventListener(TouchEvent.TOUCH_BEGIN, hnTouchBegin);
		}
		
		
		override public function destroy():void
		{
			removeEventListener(TouchEvent.TOUCH_BEGIN, hnTouchBegin);
		}
		
		
		/**
		 * 
		 * @param $e
		 * 
		 */		
		private function hnRemoveFromStage($e:TouchEvent):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, hnRemoveFromStage);
			
			var id:int = $e.touchPointID;
			var i:int = firstTouchList.length - 1;
			var te:TouchEvent;
			while(i > -1)
			{
				te = firstTouchList[i];
				if(te.touchPointID == id)
				{
					firstTouchList.splice(i, 1);
					lastTouchList.splice(i, 1);
					break;
				}
				-- i;
			}
			
			removeEventListener(TouchEvent.TOUCH_MOVE, hnTouchMove);
		}
		
		
		/**
		 * 
		 * @param $e
		 * 
		 */		
		private function hnTouchBegin($e:TouchEvent):void
		{
			firstTouchList.push($e);
			lastTouchList.push($e);
			
			addEventListener(TouchEvent.TOUCH_MOVE, hnTouchMove);
		}
		
		
		/**
		 * 
		 * @param $e
		 * 
		 */		
		private function hnTouchMove($e:TouchEvent):void
		{
			var length:uint = firstTouchList.length;
			if(length < 1)	return;	//	손가락이 하나일 땐 제스처를 체크하지 않음
			
			var id:int = $e.touchPointID;
			var index:int = firstTouchList.length - 1;
			var te:TouchEvent;
			while(i > -1)
			{
				te = firstTouchList[index];
				if(te.touchPointID == id)
				{
					lastTouchList[index] = te;
					break;
				}
				-- index;
			}
			if(index < 0)	return;
			
			var atan2:Function = Math.atan2;
			
			var i:uint = 0;
			var fcx:Number = 0;
			var fcy:Number = 0;
			while(i < length)
			{
				te = firstTouchList[i];
				fcx += te.localX;
				fcy += te.localY;
				++ i;
			}
			//	첫 모든 점의 중점
			fcx /= length;	
			fcy /= length;
			
			te = firstTouchList[index];	//	첫 터치 이벤트
			var fDistanceX:Number = te.localX - fcx;	//	첫 중점과의 거리
			var fDistanceY:Number = te.localY - fcy;
			var fRrotation:Number = atan2(fDistanceY, fDistanceX);	//	첫 중점과의 각도
			
			
			
			i = 0;
			var lcx:Number = 0;
			var lcy:Number = 0;
			while(i < length)
			{
				te = lastTouchList[i];
				lcx += te.localX;
				lcy += te.localY;
				++ i;
			}
			//	현재 모든 점의 중점
			lcx /= length;	
			lcy /= length;
			
			var localX:Number = $e.localX;
			var localY:Number = $e.localY;
			var lDistanceX:Number = localX - lcx;	//	현재 중점과의 거리
			var lDistanceY:Number = localY - lcy;
			var lRrotation:Number = atan2(lDistanceY, lDistanceX);	//	현재 중점과의 각도
			
			var _scaleX:Number = lDistanceX / fDistanceX;
			var _scaleY:Number = lDistanceY / fDistanceY;
			
			var _rotation:Number = lRrotation - fRrotation;

			var offsetX:Number = lDistanceX - fDistanceX;
			var offsetY:Number = lDistanceY - fDistanceY;
			
			var bubbles:Boolean = $e.bubbles;
			var cancelable:Boolean = $e.cancelable;
			var ctrlKey:Boolean = $e.ctrlKey;
			var altKey:Boolean = $e.altKey;
			var shiftKey:Boolean = $e.shiftKey;
			var commandKey:Boolean = $e.commandKey;
			var controlKey:Boolean = $e.controlKey;
			
			firstTouchList[index] = $e;
			
			dispatchEvent(new TransformGestureEvent(TransformGestureEvent.GESTURE_ROTATE, bubbles, cancelable, null, localX, localY, _scaleX, _scaleY, _rotation, offsetX, offsetY, ctrlKey, altKey, shiftKey, commandKey, controlKey));
			dispatchEvent(new TransformGestureEvent(TransformGestureEvent.GESTURE_ZOOM, bubbles, cancelable, null, localX, localY, _scaleX, _scaleY, _rotation, offsetX, offsetY, ctrlKey, altKey, shiftKey, commandKey, controlKey));
		}
	}
}