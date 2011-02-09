package com.minarto.display.pixelBender.alphaBlend
{
	import flash.display.BitmapData;
	import flash.display.Shader;
	import flash.filters.ShaderFilter;
	import flash.utils.ByteArray;
	
	public class AlphaBlendFilter extends ShaderFilter
	{
		[Embed("alphaBlend.pbj", mimeType="application/octet-stream")]
		private var Filter:Class;
		
		
		private var __shader:Shader;
		
		
		/**
		 * 
		 * 
		 */		
		public function AlphaBlendFilter()
		{
			__shader = new Shader(new Filter() as ByteArray);
			super(__shader);
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