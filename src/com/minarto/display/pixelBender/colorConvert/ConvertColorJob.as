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
			var v:Number = 1 / 0xFF;
			var a:Number = ($color >> 24 & 0xFF) * v;
			var r:Number = ($color >> 16 & 0xFF) * v;
			var g:Number = ($color >> 8 & 0xFF) * v;
			var b:Number = ($color & 0xFF) * v;

			__shader.data.color.value = [r, g, b, a];
		}
	}
}