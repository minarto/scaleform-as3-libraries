package com.minarto.display 
{
	import flash.display.*;
	import flash.events.Event;
	/**
	 * ...
	 * @author minarto@minarto.com
	 */
	public function documentInit($main:Sprite, $afterInit:Function=null, ...$afterInitArgs):void{
	{
		$main.addEventListener(Event.ADDED_TO_STAGE, function($e:Event):void {
				var st:Stage;
				
				$main.removeEventListener(Event.ADDED_TO_STAGE, arguments.callee);
				
				st = $main.stage;
				if (st === $main.parent) {
					st.align = StageAlign.TOP_LEFT;
					st.scaleMode = StageScaleMode.NO_SCALE;
					st.tabChildren = false;
				}
				
				if (Boolean($afterInit)) {
					$afterInit.apply(null, $afterInitArgs);
				}
			}
		)
	}
}