package com.minarto.utils.math
{
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public final class Math2
	{
		/**
		 * 
		 * @param $num0
		 * @param $operator
		 * @param $num1
		 * @return 
		 * 
		 */		
		public static function decimalCal($num0:Number, $operator:String, $num1:Number):Number
		{
			if(isNaN($num0) || isNaN($num1))	var result:Number = NaN;
			else
			{
				var ns0:String = String($num0);
				var num0:Number = ns0.indexOf(".", 0);
				if(num0 < 0)	num0 = ns0.length;
				num0 = ns0.length - num0;
				
				var ns1:String = String($num1);
				var num1:Number = ns1.indexOf(".", 0);
				if(num1 < 0)	num1 = ns1.length;
				num1 = ns1.length - num1;
				
				var pow:uint = Math.max(num0, num1);
				num1 = Math.pow(10, pow);
				num0 = Number(ns0.split(".").join("")) * num1;
				num1 = Number(ns1.split(".").join("")) * num1;
				
				
				switch($operator)
				{
					case "+" :
						result = (num0 + num1) / Math.pow(10, pow);
						break;
					case "-" :
						result = (num0 - num1) / Math.pow(10, pow);
						break;
					case "*" :
						result = (num0 * num1) / Math.pow(10, pow << 1);
						break;
					case "/" :
						if(!Number($num0))	result = 0;
						else if(!Number($num1))
						{
							result = $num0 < 0 ? - Infinity : Infinity;
						}
						else
						{
							result = num0 / num1;
						}
						break;
					default :
						throw(new Error("operator error"));
				}
			}
			
			return	result;
		}
		
		
		/**
		 * 
		 * @param $params
		 * @return 
		 * 
		 */		
		public static function decimalCals(...$params):Number
		{
			var i:uint;
			var length:uint = $params.length;
			var result:Number = length > 0 ? $params[0] : NaN;
			var operator:String;
			var num:Number;
			while((i += 2) < length)
			{
				operator = $params[i - 1];
				num = $params[i];
				result = decimalCal(result, operator, num);
			}
			
			return	result;
		}
	}
}