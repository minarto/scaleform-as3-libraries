package com.minarto.utils.date
{
	/**
	 * @author minarto
	 */
	public function getSeconds($ms:Number=0):uint
	{
		return $ms % 60000 * 0.001;
	}
}
