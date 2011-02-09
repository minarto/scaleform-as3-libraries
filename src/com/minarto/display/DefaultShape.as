package com.minarto.display
{
	import flash.display.Shape;
	
	import com.minarto.IDefaultInterface;
	
	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class DefaultShape extends Shape implements IDefaultInterface
	{
		/**
		 * 생성자
		 * 
		 */		
		public function DefaultShape()
		{
			init();
		}
		
		
		/**
		 * 초기화
		 * 
		 */		
		public function init():void
		{
		}
		
		
		/**
		 * 메모리 삭제
		 * 
		 */		
		public function destroy():void
		{
		}
	}
}