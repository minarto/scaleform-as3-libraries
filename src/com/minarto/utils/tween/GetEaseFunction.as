package com.minarto.utils.tween
{
	import caurina.transitions.Equations;

	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public final class GetEaseFunction extends Equations
	{
		/**
		 * 
		 * @param $transition
		 * @return 
		 * 
		 */		
		public static function getEase($transition:String):Function
		{
			switch($transition.toLowerCase())
			{
				case "easeinquad" :
					var f:Function = easeInQuad;
					break;
				case "easeoutquad" :
					f = easeOutQuad;
					break;
				case "easeinoutquad" :
					f = easeInOutQuad;
					break;
				case "easeoutinquad" :
					f = easeOutInQuad;
					break;
				
				
				case "easeincubic" :
					f = easeInCubic;
					break;
				case "easeoutcubic" :
					f = easeOutCubic;
					break;
				case "easeinoutcubic" :
					f = easeOutCubic;
					break;
				case "easeoutincubic" :
					f = easeOutInCubic;
					break;
				
				
				case "easeinquart" :
					f = easeInQuart;
					break;
				case "easeoutquart" :
					f = easeOutQuart;
					break;
				case "easeinoutquart" :
					f = easeInOutQuart;
					break;
				case "easeoutinquart" :
					f = easeOutInQuart;
					break;
				
				
				case "easeinquint" :
					f = easeInQuint;
					break;
				case "easeoutquint" :
					f = easeOutQuint;
					break;
				case "easeinoutquint" :
					f = easeInOutQuint;
					break;
				case "easeoutinquint" :
					f = easeOutInQuint;
					break;
				
				
				case "easeinsine" :
					f = easeInSine;
					break;
				case "easeoutsine" :
					f = easeOutSine;
					break;
				case "easeinoutsine" :
					f = easeInOutSine;
					break;
				case "easeoutinsine" :
					f = easeOutInSine;
					break;
				
				
				case "easeincirc" :
					f = easeInCirc;
					break;
				case "easeoutcirc" :
					f = easeOutCirc;
					break;
				case "easeinoutcirc" :
					f = easeInOutCirc;
					break;
				case "easeoutincirc" :
					f = easeOutInCirc;
					break;
				
				
				case "easeinexpo" :
					f = easeInExpo;
					break;
				case "easeoutexpo" :
					f = easeOutExpo;
					break;
				case "easeinoutexpo" :
					f = easeInOutExpo;
					break;
				case "easeoutinexpo" :
					f = easeOutInExpo;
					break;
				
				
				case "easeinelastic" :
					f = easeInElastic;
					break;
				case "easeoutelastic" :
					f = easeOutElastic;
					break;
				case "easeinoutelastic" :
					f = easeInOutElastic;
					break;
				case "easeoutinelastic" :
					f = easeOutInElastic;
					break;
				
				
				case "easeinback" :
					f = easeInBack;
					break;
				case "easeoutback" :
					f = easeOutBack;
					break;
				case "easeinoutback" :
					f = easeInOutBack;
					break;
				case "easeoutinback" :
					f = easeOutInBack;
					break;
				
				
				case "easeinbounce" :
					f = easeInBounce;
					break;
				case "easeoutbounce" :
					f = easeOutBounce;
					break;
				case "easeinoutbounce" :
					f = easeInOutBounce;
					break;
				case "easeoutinbounce" :
					f = easeOutInBounce;
					break;
				
				
				default :
					f = easeNone;
			}
			
			
			return	f;
		}
	}
}