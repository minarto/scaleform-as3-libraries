package com.minarto.motion
{
	import flash.display.DisplayObject;
	
    import scaleform.clik.motion.Tween;

	
    public class TweenX extends Tween
	{
        public function TweenX(duration:Number, target:Object = null, props:Object = null, quickSet:Object = null)
		{
			var name:String, tmp;
			
			if (quickSet && quickSet.fromTo)
			{
				tmp = { };
				
				if (target as DisplayObject)
				{
					for (name in propsDO)
					{
						tmp[name] = target[name];
					}
				}
				for (name in target)
				{
					tmp[name] = target[name];
				}
				
				for (name in props)
				{
					target[name] = props[name];
				}
				for (name in tmp)
				{
					props[name] = tmp[name];
				}
			}			
			
			super(duration, target, props, quickSet);
        }
		
	
		override public function quickSet(props:Object):void
		{
			for (var name:String in props)
			{
				if (name != "fromTo")
				{
					this[name] = props[name];
				}
			}
		}
	}	
}
