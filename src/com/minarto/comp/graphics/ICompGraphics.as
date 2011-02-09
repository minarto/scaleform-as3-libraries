package com.minarto.comp.graphics
{
	import flash.display.GraphicsStroke;
	import flash.display.GraphicsPath;
	import flash.display.IGraphicsData;
	import flash.display.IGraphicsFill;

	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public interface ICompGraphics
	{
		function get graphicsData():Vector.<IGraphicsData>;
		
		function get graphicsPath():GraphicsPath;
			
		function get graphicsStroke():GraphicsStroke;
			
		function set graphicsFill($v:IGraphicsFill):void;
		function get graphicsFill():IGraphicsFill;
	}
}