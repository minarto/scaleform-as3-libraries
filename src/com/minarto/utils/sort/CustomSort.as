package com.minarto.utils.sort
{
	public class CustomSort
	{
		/**
		 * 
		 * @param $item0
		 * @param $item1
		 * @return 
		 * 
		 */		
		public static function suffle($item0:Object, $item1:Object):int
		{
			return	int(Math.random() * 3) - 1;
		}
		
		
		/**
		 * 
		 * @param $item0
		 * @param $item1
		 * @return 
		 * 
		 */		
		public static function zSort($item0:Object, $item1:Object):int
		{
			if($item0.z > $item1.z)	return	- 1;
			else return	1;
		}
	}
}