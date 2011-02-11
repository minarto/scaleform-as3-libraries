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
		private const pi:Number = Math.PI / 180;
		private const absF:Function = Math.abs;
		private const ceilF:Function = Math.ceil;
		private const cosF:Function = Math.cos;
		private const sinF:Function = Math.sin;
		
		
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
			if(graphicsPath)	graphicsData.push(graphicsPath);
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
		public function draw($graphics:Graphics, $x:Number, $y:Number, $radius:Number, $yradius:Number, $startAngle:Number, $angle:Number):void
		{
			var angle:Number = absF($angle);
			if(angle >= 360)	$angle = $angle < 0 ? - 360 : 360;
			
			var commands:Vector.<int> = graphicsPath.commands;
			commands.length = 0;
			var data:Vector.<Number> = graphicsPath.data;
			data.length = 0;
			
			var radian:Number = $startAngle * pi;
			var x:Number = cosF(radian) * $radius;
			var y:Number = sinF(radian) * $yradius;
			
			commands[0] = 2;
			data[0] = $x + x;
			data[1] = $y + y;
			
			var i:uint;
			var length:uint = ceilF(Math2.decimalCal(absF($angle), "/", 45));
			angle = $angle / length;
			
			var cx:Number;
			var cy:Number;
			var addRadian:Number = angle * pi;
			var radius:Number = $radius * $radius;
			var yradius:Number = $yradius * $yradius;
			while(++i < length)
			{
				radian += addRadian;
				x = cosF(radian) * $radius;
				y = sinF(radian) * $yradius;
				
				cx = radius * (y - cy) / (cx * y - x * cy);
				cy = yradius * (x - cx) / (cy * x - y * cx);
				
				commands.push(3);
				data.push($x + cx, $y + cy, $x + x, $y + y);
				
				cx = x;
				cy = y;
			}
			
			$graphics.drawGraphicsData(graphicsData);
		}
	}
}