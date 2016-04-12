package com.minarto.graphics
{
	import com.minarto.utils.math.Math2;
	
	import flash.display.Graphics;

	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public function drawArcEllipse($g:Graphics, $x:Number, $y:Number, $radius:Number, $yradius:Number, $startAngle:Number, $angle:Number):void
	{
		var angle:Number = Math.abs($angle);
		if (angle >= 360)
		{
			$angle = $angle < 0 ? - 360 : 360;
		}
		
		var cosF:Function = Math.cos, sinF:Function = Math.sin, pi:Number = Math.PI / 180, radian:Number = $startAngle * pi;
		
		var x:Number = cosF(radian) * $radius;
		var y:Number = sinF(radian) * $yradius;
		
		$g.moveTo($x + x, $y + y);
		
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
			
			$g.curveTo($x + radius * (py - y) / (pyx - ypx), $y + yradius * (px - x) / (ypx - pyx), $x + x, $y + y);
			
			px = x;
			py = y;
		}
	}
}