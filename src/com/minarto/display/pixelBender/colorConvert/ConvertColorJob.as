package com.minarto.display.pixelBender.colorConvert
{
	import flash.display.BitmapData;
	import flash.display.Shader;
	import flash.display.ShaderJob;
	import flash.utils.ByteArray;
	
	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class ConvertColorJob extends ShaderJob
	{
		[Embed("ConvertColor.pbj", mimeType="application/octet-stream")]
		private var Filter:Class;
		
		
		private var __shader:Shader;
		
		
		/**
		 * 
		 * @param $shader
		 * @param $target
		 * @param $width
		 * @param $height
		 * 
		 */		
		public function ConvertColorJob($target:Object=null, $width:int=0, $height:int=0)
		{
			__shader = new Shader(new Filter() as ByteArray);
			super(__shader, $target, $width, $height);
		}
		
		
		/**
		 * 
		 * @param $v
		 * 
		 */		
		public function set sourceBitmapData($v:BitmapData):void
		{
			__shader.data.src.input = $v;
		}
		
		
		/**
		 * 
		 * @param $v
		 * 
		 */		
		public function set color($color:uint):void
		{
			var a:uint = $color >> 24 & 0xFF;
			var r:uint = $color >> 16 & 0xFF;
			var g:uint = $color >> 8 & 0xFF;
			var b:uint = $color & 0xFF;
			__shader.data.color.input = [r, g, b, a];
		}
	}
}