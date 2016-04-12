package com.minarto.display.graphics
{
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class DrawSpLine extends DrawingBase
	{
		public function DrawSpLine()
		{
			super();
		}
		
		
		/**
		 * http://webnoon.net/entry/Actionscript-3-Catmull-Rom-Spline-curve-code 
		 * @param $points
		 * @param $n
		 * 
		 */		
		public function draw($points:Vector.<Number>, $n:int=10):void
		{
			var length:uint = $points.length;
			if(length < 4 || $n <= 0)
			{
				graphics.drawGraphicsData(graphicsData);
				return;
			}
			
			var commands:Vector.<int> = graphicsPath.commands;
			var commandsPush:Function = commands.push;
			var data:Vector.<Number> = graphicsPath.data;
			var dataPush:Function = data.push;
			
			var sx0:Number = $points[0] * 2 - $points[2];
			var sy0:Number = $points[1] * 2 - $points[3];
			
			var sx1:Number = $points[length - 2] * 2 - $points[length - 4];
			var sy1:Number = $points[length - 1] * 2 - $points[length - 3];
			
			var fd:Number = 1 / $n;
			
			var i:int = - 1;
			var length2:uint = (length >> 1) - 1;
			var px0:Number;
			var px1:Number;
			var px2:Number;
			var px3:Number;
			var py0:Number;
			var py1:Number;
			var py2:Number;
			var py3:Number;
			
			var j:int;
			var t:Number;
			var t2:Number;
			var t3:Number;
			var x:Number;
			var y:Number;
			
			while(++ i < length2)
			{
				px0 = (i==0) ? sx0 : $points[(i << 1) - 2] ;
				px1 = $points[i << 1] ;
				px2 = $points[(i << 1) + 2] ;
				px3 = (i == (length >> 1) - 2) ? sx1 : $points[(i << 1) + 4];
				
				py0 = (i==0) ? sy0 : $points[(i << 1) - 1];
				py1 = $points[(i << 1) + 1];
				py2 = $points[(i << 1) + 3] ;
				py3 = (i == (length >> 1) - 2) ? sy1 : $points[(i << 1) + 5];

				j = - 1;
				while(++ j < $n)
				{
					t = fd * j;
					t2 = t * t;
					t3 = t2 * t;
					
					x = 0.5 * (2 * px1 + (- px0 + px2) * t + (2 * px0 - 5 * px1 + 4 * px2 - px3)* t2 + (- px0 + 3 * px1 - 3 * px2 + px3) * t3);
					y = 0.5 * (2 * py1 + (- py0 + py2) * t + (2 * py0 - 5 * py1 + 4 * py2 - py3)* t2 + (- py0 + 3 * py1 - 3 * py2 + py3) * t3);
					
					commandsPush(2);
					dataPush(x, y);
				}
			}
		}
	}
}