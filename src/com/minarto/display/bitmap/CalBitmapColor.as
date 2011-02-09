package com.minarto.display.bitmap
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;

	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class CalBitmapColor
	{
		/**
		 * 
		 * 
		 */		
		public function CalBitmapColor()
		{
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function getNearColors($bitmapData:BitmapData, $colorList:Vector.<uint>, $ruleOutRects:Vector.<Rectangle>=null):Vector.<uint>
		{
			var cLength:uint = $colorList.length;
			var rLength:uint = $ruleOutRects ? $ruleOutRects.length : 0;
			
			var x:int = $bitmapData.width - 1;
			var h:int = $bitmapData.height;
			var y:int;
			var rect:Rectangle;
			
			var gc:uint;
			var ga:uint;
			var gr:uint;
			var gg:uint;
			var gb:uint;
			
			var cc:uint;
			var ca:int;
			var cr:int;
			var cg:int;
			var cb:int;
			
			var absF:Function = Math.abs;
			var value:uint;
			
			var colors:Vector.<uint> = new Vector.<uint>(cLength, true);
			var i:uint;
			var values:Array;
			var sortType:uint = Array.NUMERIC;
			
			var k:uint;
			while(x > - 1)
			{
				y = 0;
				while(y < h)
				{
					k = 0;
					while(k < rLength)
					{
						rect = $ruleOutRects[k];
						if(x >= rect.x && x < rect.x + rect.width && y >= rect.y && y < rect.y + rect.height)	break;
						
						++ k;
					}
					
					if(k == rLength)
					{
						gc = $bitmapData.getPixel(x, y);
	
						ga = gc >> 24 & 0xFF;
						gr = gc >> 16 & 0xFF;
						gg = gc >> 8 & 0xFF;
						gb = gc & 0xFF;
						
						values = [];
						k = 0;
						while(k < cLength)
						{
							cc = $colorList[k];
							
							ca = cc >> 24 & 0xFF;
							cr = cc >> 16 & 0xFF;
							cg = cc >> 8 & 0xFF;
							cb = cc & 0xFF;
							
							ca = absF(ca - ga);
							cr = absF(cr - gr);
							cg = absF(cg - gg);
							cb = absF(cb - gb);
							
							value = ca + cr + cg + cb >> 2;
							values[k] = {index:k, value:value};
							
							++ k;
						}
						
						values.sortOn("value", sortType);
						
						colors[values[0].index] ++;
					}					
					
					
					++ i;
					
					++ y;
				}
				-- x;
			}
			
			return	colors;
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function removeNearColor($colorList:Vector.<uint>, $averageNear:uint):Vector.<uint>
		{
			var colorList:Vector.<uint> = $colorList.concat();
			colorList.fixed = false;
			colorList.sort(Array.NUMERIC);
			
			var length:uint = colorList.length;
			var i:uint = 1;
			
			var c:uint;
			var a:uint;
			var r:uint;
			var g:uint;
			var b:uint;
			
			var ac:uint;
			var aa:uint;
			var ar:uint;
			var ag:uint;
			var ab:uint;
			
			var absF:Function = Math.abs;
			var av:uint;
			var j:int;
			
			while(i < length)
			{
				c = colorList[i];
				
				a = c >> 24 & 0xFF;
				r = c >> 16 & 0xFF;
				g = c >> 8 & 0xFF;
				b = c & 0xFF;
				
				j = i + 1;
				while(j < length)
				{
					ac = colorList[j];
					aa = ac >> 24 & 0xFF;
					ar = ac >> 16 & 0xFF;
					ag = ac >> 8 & 0xFF;
					ab = ac & 0xFF;
					
					av = absF(a - aa) + absF(r - ar) + absF(g - ag) + absF(b - ab) >> 2;
					if(av < $averageNear)
					{
						colorList.splice(j, 1);
						-- length;
						-- j;
					}

					++ j;
				}
				
				++ i;
			}
			
			return	colorList;
		}
	}
}