package com.minarto.utils.date
{
	/**
	 * @author minarto
	 */
	public function getMinutes($ms:Number=0):uint
	{
		return $ms % 3600000 / 60000;
	}
}
