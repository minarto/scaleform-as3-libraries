package com.minarto.font
{
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.GridFitType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class FontUtils
	{
		/**
		 * 
		 * @return 
		 * 
		 */		
		public static function getFontNameList($embed:Boolean=false):Vector.<String>
		{
			var fonts:Array = Font.enumerateFonts(!$embed);
			var length:uint = fonts.length;
			var fontList:Vector.<String> = new Vector.<String>(length, true);
			var i:uint;
			while(i < length)
			{
				fontList[i] = fonts[i].fontName;
				
				++ i;
			}
			
			return	fontList;
		}
		
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function getEmbedTextField($textFormat:TextFormat):TextField
		{
			var txt:TextField = new TextField();
			txt.defaultTextFormat = $textFormat;
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.embedFonts = true;
			txt.gridFitType = GridFitType.PIXEL;
			txt.antiAliasType = AntiAliasType.ADVANCED;
			
			return	txt;
		}
	}
}