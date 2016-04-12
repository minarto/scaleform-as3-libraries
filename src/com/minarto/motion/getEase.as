package com.minarto.motion
{
	import caurina.transitions.Equations;
	
	
	/**
	 * @author minarto
	 */
	public function getEase($transition:String = ""):Function
	{
		switch($transition.toLowerCase())
		{
			case "easeinquad" :
				return Equations.easeInQuad;
			case "easeoutquad" :
				return Equations.easeOutQuad;
			case "easeinoutquad" :
				return Equations.easeInOutQuad;
			case "easeoutinquad" :
				return Equations.easeOutInQuad;
			
			case "easeincubic" :
				return Equations.easeInCubic;
			case "easeoutcubic" :
				return Equations.easeOutCubic;
			case "easeinoutcubic" :
				return Equations.easeOutCubic;
			case "easeoutincubic" :
				return Equations.easeOutInCubic;
			
			case "easeinquart" :
				return Equations.easeInQuart;
			case "easeoutquart" :
				return Equations.easeOutQuart;
			case "easeinoutquart" :
				return Equations.easeInOutQuart;
			case "easeoutinquart" :
				return Equations.easeOutInQuart;
			
			case "easeinquint" :
				return Equations.easeInQuint;
			case "easeoutquint" :
				return Equations.easeOutQuint;
			case "easeinoutquint" :
				return Equations.easeInOutQuint;
			case "easeoutinquint" :
				return Equations.easeOutInQuint;
			
			case "easeinsine" :
				return Equations.easeInSine;
			case "easeoutsine" :
				return Equations.easeOutSine;
			case "easeinoutsine" :
				return Equations.easeInOutSine;
			case "easeoutinsine" :
				return Equations.easeOutInSine;
			
			case "easeincirc" :
				return Equations.easeInCirc;
			case "easeoutcirc" :
				return Equations.easeOutCirc;
			case "easeinoutcirc" :
				return Equations.easeInOutCirc;
			case "easeoutincirc" :
				return Equations.easeOutInCirc;
			
			case "easeinexpo" :
				return Equations.easeInExpo;
			case "easeoutexpo" :
				return Equations.easeOutExpo;
			case "easeinoutexpo" :
				return Equations.easeInOutExpo;
			case "easeoutinexpo" :
				return Equations.easeOutInExpo;
			
			case "easeinelastic" :
				return Equations.easeInElastic;
			case "easeoutelastic" :
				return Equations.easeOutElastic;
			case "easeinoutelastic" :
				return Equations.easeInOutElastic;
			case "easeoutinelastic" :
				return Equations.easeOutInElastic;
			
			case "easeinback" :
				return Equations.easeInBack;
			case "easeoutback" :
				return Equations.easeOutBack;
			case "easeinoutback" :
				return Equations.easeInOutBack;
			case "easeoutinback" :
				return Equations.easeOutInBack;
			
			case "easeinbounce" :
				return Equations.easeInBounce;
			case "easeoutbounce" :
				return Equations.easeOutBounce;
			case "easeinoutbounce" :
				return Equations.easeInOutBounce;
			case "easeoutinbounce" :
				return Equations.easeOutInBounce;
		}
		
		return	return Equations.easeNone;
	}
}
