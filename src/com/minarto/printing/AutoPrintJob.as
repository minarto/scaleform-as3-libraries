package com.minarto.printing
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.printing.PrintJob;
	import flash.printing.PrintJobOrientation;
	
	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class AutoPrintJob
	{
		/**
		 * 
		 */		
		public var showScale:String = StageScaleMode.SHOW_ALL;
		public var align:String = StageAlign.TOP_LEFT;
		public var xpadding:int;
		public var ypadding:int;
		
		
		/**
		 * 
		 * 
		 */		
		public function AutoPrintJob()
		{
		}
		
		
		/**
		 * 
		 * @param $e
		 * 
		 */		
		public function addPage($page:DisplayObject):void
		{
			var printJob:PrintJob = new PrintJob();
			var w:int = printJob.pageWidth;
			var h:int = printJob.pageHeight;
			
			if($page as Bitmap)
			{
				var bd:BitmapData = ($page as Bitmap).bitmapData.clone()
			}
			else
			{
				bd = new BitmapData($page.width, $page.height, false, 0xFFFFFF);
				bd.draw($page);
			}
			var bm:Bitmap = new Bitmap(bd, PixelSnapping.AUTO, true);
			
			var printPage:Sprite = new Sprite();
			printPage.addChild(bm);
			
			switch(printJob.orientation)
			{
				case PrintJobOrientation.PORTRAIT :
					if(bd.width > bd.height)	bm.rotation = 90;
					break;
				case PrintJobOrientation.LANDSCAPE :
					if(bd.width < bd.height)	bm.rotation = 90;
					break;
			}
			
			var scale:Number = Math.min(w / (bm.width - (xpadding << 1)), h / (bm.height - (ypadding << 1)));
			bm.scaleX = scale;
			bm.scaleY = scale;
			bm.x = xpadding + (w - bm.width >> 1);
			bm.y = ypadding + (h - bm.height >> 1);
			var gr:Graphics = printPage.graphics;
			gr.beginFill(0xFFFFFF);
			gr.drawRect(0, 0, w, h);
			
			if(printJob.start2(null, false))
			{
				try
				{
					printJob.addPage(printPage);
				}
				catch(error:Error)
				{
					
				}
			}
			
			bd.dispose();
		}
	}
}