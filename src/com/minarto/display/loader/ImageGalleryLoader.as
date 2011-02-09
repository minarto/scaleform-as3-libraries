package com.minarto.display.loader
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	
	import flash.events.IOErrorEvent;
	
	import com.minarto.IDefaultInterface;
	
	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class ImageGalleryLoader extends LoaderMax implements IDefaultInterface
	{
		/**
		 * 
		 */		
		public var source:Vector.<String>;
		
		
		/**
		 * 
		 * @param vars
		 * 
		 */		
		public function ImageGalleryLoader(vars:Object=null)
		{
			super(vars);
			init();
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function init():void
		{
			
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function destroy():void
		{
			
		}
		
		
		override public function load(flushContent:Boolean=false):void
		{
			if(source)
			{
				var length:uint = source.length;
				var i:uint;
				
				while(i < length)
				{
					append(new ImageLoader(source[i]));
					
					++ i;
				}
				
				super.load(flushContent);
			}
			else
			{
				dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
			}
		}
	}
}