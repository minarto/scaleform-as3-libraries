package com.minarto.display.graphics
{
	import flash.display.Graphics;
	import flash.display.GraphicsEndFill;
	import flash.display.GraphicsPath;
	import flash.display.GraphicsSolidFill;
	import flash.display.GraphicsStroke;
	import flash.display.IGraphicsData;
	import flash.display.IGraphicsFill;
	
	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class DrawingBase implements IDrawing
	{
		private var __graphicsData:Vector.<IGraphicsData>;
		public function get graphicsData():Vector.<IGraphicsData>
		{
			return	__graphicsData;
		}
		
		
		private var __graphicsPath:GraphicsPath;
		public function set graphicsPath($v:GraphicsPath):void
		{
			__graphicsPath = $v;
		}
		public function get graphicsPath():GraphicsPath
		{
			return	__graphicsPath;
		}
		
		
		/**
		 * 
		 */		
		private var __graphicsStroke:GraphicsStroke;
		public function set graphicsStroke($v:GraphicsStroke):void
		{
			__graphicsStroke = $v;
		}
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
			__graphicsFill = $v;
		}
		public function get graphicsFill():IGraphicsFill
		{
			return	__graphicsFill;
		}
		
		
		public var graphics:Graphics;
		

		/**
		 * 
		 * 
		 */		
		public function DrawingBase()
		{
			__graphicsData = Vector.<IGraphicsData>([]);
			init();
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function init():void
		{
			__graphicsData.length = 0;
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function destroy():void
		{
			__graphicsData = null;
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function defaultDraw():void
		{
			graphics.drawGraphicsData(__graphicsData);
		}
	}
}