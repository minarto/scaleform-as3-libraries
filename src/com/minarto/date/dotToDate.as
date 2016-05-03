package com.minarto.date
{
	public function dotToDate($date:String):Date
	{
		var a:Array;
		
		if($date)
		{
			a = $date.split(".");
			
			return	new Date(uint(a[0]), uint(a[1]), uint(a[2]), uint(a[3]), uint(a[4]), uint(a[5]), uint(a[6]));
		}
		else	return	new Date;
	}
}
