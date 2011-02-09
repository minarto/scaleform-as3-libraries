package com.minarto.display
{
	import flash.display.Sprite;
	
	import com.minarto.IDefaultInterface;
	
	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class DefaultSprite extends Sprite implements IDefaultInterface
	{
		/**
		 * 생성자
		 * 
		 */		
		public function DefaultSprite()
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