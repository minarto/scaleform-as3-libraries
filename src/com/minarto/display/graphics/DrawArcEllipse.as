package com.minarto.display.graphics
{
	import com.minarto.utils.math.Math2;
	
	import flash.display.Graphics;

	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public final class DrawArcEllipse extends DrawingBase
	{
		private const pi:Number = Math.PI / 180;
		private const absF:Function = Math.abs;
		private const ceilF:Function = Math.ceil;
		private const cosF:Function = Math.cos;
		private const sinF:Function = Math.sin;
		
		
		/**
		 * 
		 * 
		 */		
		public function DrawArcEllipse()
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
		public function draw($x:Number, $y:Number, $radius:Number, $yradius:Number, $startAngle:Number, $angle:Number):void
		{
			var angle:Number = absF($angle);
			if(angle >= 360)	$angle = $angle < 0 ? - 360 : 360;
			
			var commands:Vector.<int> = graphicsPath.commands;
			var data:Vector.<Number> = graphicsPath.data;
			
			var radian:Number = $startAngle * pi;
			var x:Number = cosF(radian) * $radius;
			var y:Number = sinF(radian) * $yradius;
			
			commands.push(2);
			data.push($x + x, $y + y);
			
			var length:uint = ceilF(absF(Math2.decimalCal($angle, "/", 45)));
			var i:int = - length - 1;
			
			var addRadian:Number = $angle / length * pi;
			
			var px:Number = x;
			var py:Number = y;
			
			var pyx:Number;
			var ypx:Number;
			
			var radius:Number = $radius * $radius;
			var yradius:Number = $yradius * $yradius;
			while(++ i < 0)
			{
				radian += addRadian;
				x = cosF(radian) * $radius;
				y = sinF(radian) * $yradius;
				
				pyx = py * x;
				ypx = y * px;
				
				commands.push(3);
				data.push($x + radius * (py - y) / (pyx - ypx), $y + yradius * (px - x) / (ypx - pyx), $x + x, $y + y);
				
				px = x;
				py = y;
			}
			
			graphics.drawGraphicsData(graphicsData);
		}
	}
}