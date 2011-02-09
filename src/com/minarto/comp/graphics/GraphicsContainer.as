package com.minarto.comp.graphics
{
	import flash.display.GraphicsEndFill;
	import flash.display.GraphicsPath;
	import flash.display.GraphicsSolidFill;
	import flash.display.GraphicsStroke;
	import flash.display.IGraphicsData;
	import flash.display.IGraphicsFill;
	import flash.events.Event;
	
	import com.minarto.events.CompEventType;
	import com.minarto.display.CustomSizeSprite;
	
	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class GraphicsContainer extends CustomSizeSprite implements ICompGraphics
	{
		private var __graphicsData:Vector.<IGraphicsData>;
		public function get graphicsData():Vector.<IGraphicsData>
		{
			return	__graphicsData;
		}
		
		
		private var __graphicsPath:GraphicsPath;
		public function get graphicsPath():GraphicsPath
		{
			return	__graphicsPath;
		}
		
		
		/**
		 * 
		 */		
		private var __graphicsStroke:GraphicsStroke;
		public function get graphicsStroke():GraphicsStroke
		{
			return	__graphicsStroke;
		}
		
		
		/**
		 * 
		 */		
		private var __graphicsFill:IGraphicsFill;
		public function set graphicsFill($v:IGraphicsFill):void
		{
			if($v == graphicsFill)	return;
			__graphicsFill = $v;
			dispatchEvent(new Event(CompEventType.DESIGN_CHANGE));
		}
		public function get graphicsFill():IGraphicsFill
		{
			return	__graphicsFill;
		}
		
		
		/**
		 * 
		 */		
		private var __rounding:int;
		public function set rounding($v:int):void
		{
			if($v == rounding)	return;
			__rounding = $v;
			dispatchEvent(new Event(CompEventType.DESIGN_CHANGE));
		}
		public function get rounding():int
		{
			return	__rounding;
		}
		
		
		/**
		 * 
		 */		
		private var __leftPadding:int;
		public function set leftPadding($v:int):void
		{
			if($v == leftPadding)	return;
			__leftPadding = $v;
			dispatchEvent(new Event(CompEventType.IN_RESIZE));
		}
		public function get leftPadding():int
		{
			return	__leftPadding;
		}
		
		
		/**
		 * 
		 */		
		private var __rightPadding:int;
		public function set rightPadding($v:int):void
		{
			if($v == rightPadding)	return;
			__rightPadding = $v;
			dispatchEvent(new Event(CompEventType.IN_RESIZE));
		}
		public function get rightPadding():int
		{
			return	__rightPadding;
		}
		
		
		/**
		 * 
		 */		
		private var __topPadding:int;
		public function set topPadding($v:int):void
		{
			if($v == topPadding)	return;
			__topPadding = $v;
			dispatchEvent(new Event(CompEventType.IN_RESIZE));
		}
		public function get topPadding():int
		{
			return	__topPadding;
		}
		
		
		/**
		 * 
		 */		
		private var __bottomPadding:int;
		public function set bottomPadding($v:int):void
		{
			if($v == bottomPadding)	return;
			__bottomPadding = $v;
			dispatchEvent(new Event(CompEventType.IN_RESIZE));
		}
		public function get bottomPadding():int
		{
			return	__bottomPadding;
		}
		
		
		/**
		 * 사이즈 설정 
		 * @param $w
		 * @param $h
		 * 
		 */		
		public function setPadding($l:int, $r:int, $t:int, $b:int):void
		{
			if($l == leftPadding && $r == topPadding && $t == rightPadding && $b == bottomPadding)	return;
			__leftPadding = $l;
			__rightPadding = $r;
			__topPadding = $t;
			__bottomPadding = $b;
			dispatchEvent(new Event(CompEventType.IN_RESIZE));
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function GraphicsContainer()
		{
			const commands:Vector.<int> = Vector.<int>([1, 2, 3, 2, 3, 2, 3, 2, 3]);
			commands.fixed = true;

			const data:Vector.<Number> = Vector.<Number>([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
			data.fixed = true;
			
			__graphicsPath = new GraphicsPath(commands, data);
			__graphicsStroke = new GraphicsStroke();
			__graphicsData = Vector.<IGraphicsData>([__graphicsStroke, null, __graphicsPath, new GraphicsStroke(), new GraphicsEndFill()]);
			__graphicsData.fixed = true;
			
			addEventListener(Event.RESIZE, hnReSize);
			addEventListener(CompEventType.DESIGN_CHANGE, hnDesignChange);
		}
		
		
		override public function destroy():void
		{
			removeEventListener(Event.RESIZE, hnReSize);
			removeEventListener(CompEventType.DESIGN_CHANGE, hnDesignChange);
		}
		
		
		/**
		 * 
		 * 
		 */		
		protected function hnReSize($e:Event):void
		{
			graphics.clear();
			draw();
		}
		
		
		/**
		 * 
		 * 
		 */		
		protected function hnDesignChange($e:Event):void
		{
			__graphicsData[1] = __graphicsFill as IGraphicsData;
			graphics.clear();
			draw();
		}
		
		
		/**
		 * 
		 * 
		 */		
		private function draw():void
		{
			const data:Vector.<Number> = __graphicsPath.data;
			data[0] = __rounding;
			data[2] = width - __rounding;
			data[4] = width;
			data[6] = width;
			data[7] = __rounding;
			data[8] = width;
			data[9] = height - __rounding;
			data[10] = width;
			data[11] = height;
			data[12] = width - __rounding;
			data[13] = height;
			data[14] = __rounding;
			data[15] = height;
			data[17] = height;
			data[19] = height - __rounding;
			data[21] = __rounding;
			data[24] = __rounding;
			
			graphics.drawGraphicsData(__graphicsData);
		}
	}
}