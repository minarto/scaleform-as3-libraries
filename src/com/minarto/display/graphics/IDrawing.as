package com.minarto.display.graphics
{
	import com.minarto.IDefaultInterface;
	
	import flash.display.GraphicsPath;
	import flash.display.GraphicsStroke;
	import flash.display.IGraphicsData;
	import flash.display.IGraphicsFill;

	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public interface IDrawing extends IDefaultInterface
	{
		function get graphicsData():Vector.<IGraphicsData>;
		
		function set graphicsPath($v:GraphicsPath):void;
		function get graphicsPath():GraphicsPath;
		
		function set graphicsStroke($v:GraphicsStroke):void;
		function get graphicsStroke():GraphicsStroke;
			
		function set graphicsFill($v:IGraphicsFill):void;
		function get graphicsFill():IGraphicsFill;
	}
}