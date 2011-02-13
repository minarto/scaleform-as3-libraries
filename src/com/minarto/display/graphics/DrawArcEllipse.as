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
		/**
		 * 
		 * 
		 */		
		public function DrawArcEllipse()
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
		public function draw($x:Number, $y:Number, $radius:Number, $yradius:Number, $startAngle:Number, $angle:Number):void
		{
			var angle:Number = Math.abs($angle);
			if(angle >= 360)	$angle = $angle < 0 ? - 360 : 360;
			
			var commands:Vector.<int> = graphicsPath.commands;
			var commandsPush:Function = commands.push;
			var data:Vector.<Number> = graphicsPath.data;
			var dataPush:Function = data.push;
			
			var cosF:Function = Math.cos;
			var sinF:Function = Math.sin;
			
			var pi:Number = Math.PI / 180;
			var radian:Number = $startAngle * pi;
			var x:Number = cosF(radian) * $radius;
			var y:Number = sinF(radian) * $yradius;
			
			commands.push(2);
			data.push($x + x, $y + y);
			
			var length:uint = Math.ceil(Math.abs(Math2.decimalCal($angle, "/", 45)));
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
				
				commandsPush(3);
				dataPush($x + radius * (py - y) / (pyx - ypx), $y + yradius * (px - x) / (ypx - pyx), $x + x, $y + y);
				
				px = x;
				py = y;
			}
			
			graphics.drawGraphicsData(graphicsData);
		}
	}
}