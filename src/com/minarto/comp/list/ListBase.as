package com.minarto.comp.list
{
	import com.minarto.display.DefaultSprite;
	import com.minarto.events.CompEventType;
	import com.minarto.events.DefaultEventType;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class ListBase extends DefaultSprite
	{
		/**
		 * 
		 */		
		private var __dataProvider:Vector.<DisplayObject>;
		public function set dataProvider($v:Vector.<DisplayObject>):void
		{
			if(dataProvider == $v)	return;
			__dataProvider = $v;
			dispatchEvent(new Event(DefaultEventType.DATA_CHANGE));
		}
		public function get dataProvider():Vector.<DisplayObject>
		{
			return	__dataProvider;
		}
		
		
		override public function init():void
		{
			addEventListener(DefaultEventType.DATA_CHANGE, hnDataChange);
			addEventListener(MouseEvent.MOUSE_DOWN, hnDown);
			
			addEventListener(Event.REMOVED_FROM_STAGE, hnRemovedFromStage);
		}
		
		
		override public function destroy():void
		{
			removeEventListener(DefaultEventType.DATA_CHANGE, hnDataChange);
			removeEventListener(MouseEvent.MOUSE_DOWN, hnDown);
			
			if(stage)	stage.removeEventListener(MouseEvent.MOUSE_UP, hnUp);
		}
		
		
		/**
		 * 
		 * @param $e
		 * 
		 */		
		protected function hnRemovedFromStage($e:Event):void
		{
			if(stage)	stage.removeEventListener(MouseEvent.MOUSE_UP, hnUp);
		}
		
		
		/**
		 * 
		 * @param $e
		 * 
		 */			
		protected function hnDataChange($e:Event):void
		{
			while(numChildren > 0)
			{
				removeChildAt(0);
			}
			
			hnReSize(null);
		}
		
		
		/**
		 * 
		 */		
		protected var sx:Number;
		protected var sy:Number;
		
		
		/**
		 * 
		 * @param $e
		 * 
		 */			
		protected function hnDown($e:MouseEvent):void
		{
			if(!mouseChildren)	return;
			sx = mouseX;
			sy = mouseY;
			
			if(stage)	stage.addEventListener(MouseEvent.MOUSE_UP, hnUp);
		}
		
		
		/**
		 * 
		 * @param $e
		 * 
		 */			
		protected function hnUp($e:MouseEvent):void
		{
			if(stage)	stage.removeEventListener(MouseEvent.MOUSE_UP, hnUp);
			if(!mouseChildren)	return;
			
			var _x:Number = mouseX;
			var _y:Number = mouseY;
			
			if(sx == _x && sy == _y)
			{
				var item:DisplayObject;
				var i:int = dataProvider ? dataProvider.length - 1 : - 1;
				var index:int;
				while(i > - 1)
				{
					item = dataProvider[i];
					if(item.x < _x && item.x + item.width > _x && item.y < _y && item.y + item.height > _y)
					{
						selectItem = item;
						break;
					}
					
					-- i;
				}
				if(i == -1)
				{
					selectItem = null;
				}
			}
		}
		
		
		/**
		 * 
		 * @param $e
		 * 
		 */		
		protected function hnReSize($e:Event):void
		{
		}
		
		
		/**
		 * 
		 * @param $obj
		 * 
		 */		
		public function addItem($obj:DisplayObject):DisplayObject
		{
			if(!dataProvider)	dataProvider = new Vector.<DisplayObject>();
			
			dataProvider.push($obj);
			hnReSize(null);
			
			return	$obj;
		}
		
		
		/**
		 * 
		 * @param $obj
		 * @param $index
		 * @return 
		 * 
		 */			
		public function addItemAt($obj:DisplayObject, $index:uint):DisplayObject
		{
			if(!dataProvider)	dataProvider = new Vector.<DisplayObject>();
			
			dataProvider.splice($index, 0, $obj);
			hnReSize(null);
			
			return	$obj;
		}
		
		
		/**
		 * 
		 * @param $obj
		 * 
		 */		
		public function removeItem($obj:DisplayObject):DisplayObject
		{
			dataProvider.splice(dataProvider.indexOf($obj, 0), 1);
			hnReSize(null);
			
			return	$obj;
		}
		
		
		/**
		 * 
		 * @param $index
		 * @return 
		 * 
		 */			
		public function removeItemIndex($index:uint):DisplayObject
		{
			var _obj:DisplayObject = dataProvider[$index];
			dataProvider.splice($index, 1);
			hnReSize(null);
			
			return	_obj;
		}
		
		
		/**
		 * 
		 */		
		private var __selectItem:DisplayObject;
		public function set selectItem($v:DisplayObject):void
		{
			if($v == selectItem)	return;
			__selectItem = $v;
			__selectIndex = dataProvider.indexOf(__selectItem, 0);

			dispatchEvent(new Event(CompEventType.SELECT_ITEM_CHANGE));
		}
		public function get selectItem():DisplayObject
		{
			return	__selectItem;
		}
		
		
		/**
		 * 
		 */		
		private var __selectIndex:int = - 1;
		public function get selectIndex():int
		{
			return	__selectIndex;
		}
	}
}