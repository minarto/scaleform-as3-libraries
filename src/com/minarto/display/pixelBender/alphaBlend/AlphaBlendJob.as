package com.minarto.display.pixelBender.alphaBlend
{
	import flash.display.BitmapData;
	import flash.display.Shader;
	import flash.display.ShaderJob;
	import flash.utils.ByteArray;
	
	public class AlphaBlendJob extends ShaderJob
	{
		[Embed("alphaBlend.pbj", mimeType="application/octet-stream")]
		private var Filter:Class;
		
		
		private var __shader:Shader;
		
		
		/**
		 * 
		 * 
		 */		
		public function AlphaBlendJob($target:Object, $width:int=0, $height:int=0)
		{
			__shader = new Shader(new Filter() as ByteArray);
			super(__shader, $target, $width, $height);
		}
		
		
		/**
		 * 
		 * @param $v
		 * 
		 */		
		public function set bottomBitmapData($v:BitmapData):void
		{
			__shader.data.bottom.input = $v;
		}
		
		
		/**
		 * 
		 * @param $v
		 * 
		 */		
		public function set topBitmapData($v:BitmapData):void
		{
			__shader.data.top.input = $v;
		}
	}
}