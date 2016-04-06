package com.minarto.data
{
	import flash.utils.*;
	

	public class DBind extends Bind
	{
		static private const bind:Bind = new Bind;
		
		
		static private var _offsetTime:Number, _uid:uint;
		
		
		static private function _getOffsetTime():Number
		{
			if(isNaN(_offsetTime))
			{
				var date:Date;
				
				var onTime:Function = function($year:uint, $month:uint, $date:uint, $hour:uint, $sec:uint, $millisec:uint=0):void
				{
					var date:Date = new Date($year, $month, $date, $hour, $sec, $millisec);
					
					_offsetTime = date.time - getTimer();
				};
				
				bind.add("serverDate", onTime);
				
				date = new Date;
				bind.evt("serverDate", date.fullYear, date.month, date.date, date.hours, date.minutes, date.seconds, date.milliseconds);
			}
			
			return	_offsetTime;
		}
		
		
		static public function getDate():Date
		{
			return	new Date(_getOffsetTime() + getTimer());
		}
		
		
		public function toString():String
		{
			return	"[com.minarto.data.DBind interval:" + getInterval() + "sec]"
		}
		
		
		protected var interval:uint = 100, intervalID:Number;
		
		
		public function init($interval:Number = 0.1):void
		{
			interval = $interval * 1000;
			
			if (intervalID)
			{
				play();
			}
		}
		
		
		/**
		 * 
		 */		
		protected function intervalFunc():void
		{
			var key:String, date:Date = getDate();
			
			for (key in _handlerDic)
			{
				evt(key, date);
			}
		}
		
		
		/**
		 * 알람 등록 
		 * 
		 */		
		public function play():void
		{
			clearInterval(intervalID);
			intervalID = setInterval(intervalFunc, interval);
		}
		
		
		/**
		 * 알람 등록 
		 * 
		 */		
		public function stop():void
		{
			clearInterval(intervalID);
			intervalID = NaN;
		}
		
		
		/**
		 * 알람 등록 
		 * 
		 */		
		public function getIsPlaying():Boolean
		{
			return	intervalID;
		}
		
		
		public function getInterval():Number
		{
			return	interval * 0.001;
		}
	}
}
