package com.minarto.date
{
	public class DateUtils
	{
		/**
		 * 
		 * @param $date
		 * @return 
		 * 
		 */		
		public static function dotToDate($date:String):Date
		{
			if($date)
			{
				var year:uint = uint($date.substr(0, $date.indexOf(".")));
				var month:uint = uint($date.substr($date.indexOf(".") + 1, $date.indexOf(".")));
				var _date:uint = uint($date.substr($date.lastIndexOf(".") + 1, $date.length - 1));
				var date:Date = new Date(year, month, date);
			}
			else	date = new Date();
			
			
			return	date;
		}
		
		
		/**
		 * 
		 * @param $date
		 * @return 
		 * 
		 */		
		public static function dateToString($date:Date=null):StringDateInfo
		{
			var stringDateInfo:StringDateInfo = new StringDateInfo();
			
			$date = $date ? $date : new Date();
			stringDateInfo.year = String($date.getFullYear());
			
			var month:uint = $date.getMonth() + 1;
			stringDateInfo.month = (month < 10) ? "0" + month : String(month);

			var hour:uint = $date.getHours();
			stringDateInfo.hour = (hour < 10) ? "0" + hour : String(hour);
			
			var date:uint = $date.getDate();
			stringDateInfo.date = (date < 10) ? "0" + date : String(date);
			
			var minute:uint = $date.getMinutes();
			stringDateInfo.minute = (minute < 10) ? "0" + minute : String(minute);
			
			var sec:uint = $date.getSeconds();
			stringDateInfo.second = (sec < 10) ? "0" + sec : String(sec);
			
			
			return	stringDateInfo;
		}
	}
}