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
			graphicsData.push(endFill);
			graphicsData.push(endStrocke);
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
		public function draw($graphics:Graphics, $x:Number, $y:Number, $radius:Number, $startAngle:Number, $angle:Number):void
		{
			var angle:Number = absF($angle);
			if(angle >= 360)	$angle = $angle < 0 ? - 360 : 360;
			
			var commands:Vector.<int> = graphicsPath.commands;
			commands.length = 0;
			var data:Vector.<Number> = graphicsPath.data;
			data.length = 0;
			
			var radian:Number = $startAngle * pi;
			var sx:Number = cosF(radian) * $radius;
			var sy:Number = sinF(radian) * $radius;
			
			commands[0] = 2;
			data[0] = sx;
			data[1] = sy;
			
			var i:uint;
			var length:uint = ceilF(Math2.decimalCal(absF($angle), "/", 45));
			angle = $angle / length;
			
			$graphics.drawGraphicsData(graphicsData);
		}
	}
}