package com.minarto.utils.sort
{
	/**
	 * @author minarto
	 */
	public function zsort($item0:*, $item1:*):int
	{
		if ($item0.z > $item1.z)
		{
			return	- 1;
		}
		else
		{
			return	1;
		}
	}
}
