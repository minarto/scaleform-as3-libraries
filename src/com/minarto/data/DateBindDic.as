package com.minarto.data
{
	public class DateBindDic
	{
		static private const _dic:* = {};
		
		
		static public function get($delay:Number=0.1):DateBind
		{
			var db:DateBind = _dic[$delay];
			
			if (!db)
			{
				_dic[$delay] = db = new DateBind;
				db.init($delay);
			}
			
			return	db;
		}
	}
}
