package com.minarto.display.graphics
{
	import com.minarto.utils.math.Math2;
	
	import flash.display.Graphics;
	
	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public final class DrawArcCircle extends DrawingBase
	{
		private const drawF:Function = (new DrawArcEllipse()).draw;
		
		
		/**
		 * 
		 * 
		 */		
		public function DrawArcCircle()
		{
			super();
		}
		
		
		override public function init():void
		{
			super.init();
			
			if(graphicsStroke)	graphicsData[0] = graphicsStroke;
			if(graphicsFill)	graphicsData.push(graphicsFill);
			graphicsData.push(graphicsPath);
		}
		
		
		/**
		 * 
		 * @param $graphics
		 * @param $x
		 * @param $y
		 * @param $radius
		 * @param $startAngle
		 * @param $angle
		 * 
		 */		
		public function draw($x:Number, $y:Number, $radius:Number, $startAngle:Number, $angle:Number):void
		{
			drawF($x, $y, $radius, $radius, $startAngle, $angle);
		}
	}
}