package com.minarto.display.graphics
{
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