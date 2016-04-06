package com.minarto.data
{
	public class DBindDic
	{
		static private const _dic:* = {};
		
		
		static public function get($delay:Number=0.1):DBind
		{
			var db:DBind = _dic[$delay];
			
			if (!db)
			{
				_dic[$delay] = db = new DBind;
				db.init($delay);
			}
			
			return	db;
		}
	}
}
