package com.minarto.media.video
{
	import com.minarto.IDefaultInterface;
	import com.minarto.events.DefaultEventType;
	import com.minarto.events.VideoEventType;
	
	import flash.display.BitmapData;
	import flash.events.*;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.*;
	
	
	/**
	 */
	public class VideoThumbnailMaker extends Video implements IDefaultInterface
	{
		/**
		 * 
		 */		
		private var __stream:NetStream;
		private var __connection:NetConnection;
		private var __makerBd:BitmapData;
		public var thumbNailTime:Number;
		
		
		/**
		 * 영상 소스
		 */		
		private var __source:String;
		public function set source($v:String):void
		{
			if($v == source)	return;
			__source = $v;
			dispatchEvent(new Event(DefaultEventType.DATA_CHANGE));
		}
		public function get source():String
		{
			return	__source;
		}
		
		
		/**
		 * 썸네일
		 */		
		private var __bitmapData:BitmapData;
		public function get bitmapData():BitmapData
		{
			return	__bitmapData;
		}
		
		
		/**
		 */
		public function VideoThumbnailMaker()
		{
			smoothing = true;
			init();
		}
		
		
		/**
		 * 
		 */		
		public function init():void
		{
			__connection = new NetConnection();
			__connection.connect(null);
			__connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			
			__stream = new NetStream(__connection);
			__stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			__stream.client = this;
			attachNetStream(__stream);
			
			addEventListener(DefaultEventType.DATA_CHANGE, hnSourceChange);
		}
		
		
		/**
		 * 
		 */		
		public function destroy():void
		{
			__connection.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			
			removeEventListener(DefaultEventType.DATA_CHANGE, hnSourceChange);
			
			__stream.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			
			removeEventListener(Event.ENTER_FRAME, hnEnterFrame);
			
			
			try
			{
				__stream.close();
			}
			catch(error:Error)
			{
				
			}
		}
		
		
		/**
		 * 
		 * @param $info
		 * 
		 */		
		public function onMetaData($info:Object):void
		{
			__bitmapData = new BitmapData(width, height, false, 0x00000000);
			__makerBd = new BitmapData(width, height, false, 0x00000000);
			
			clear();
			
			__stream.seek(isNaN(thumbNailTime) ? uint(Math.random() * $info.duration * .8 + $info.duration * .1) : thumbNailTime);
			
			addEventListener(Event.ENTER_FRAME, hnEnterFrame);
		}
		
		
		
		/**
		 * 
		 */
		private function hnEnterFrame($e:Event):void
		{
			__makerBd.draw(this);
			
			if(__bitmapData.compare(__makerBd))
			{
				removeEventListener(Event.ENTER_FRAME, hnEnterFrame);
				
				__bitmapData = __makerBd;
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		
		/**
		 * 
		 */
		private function hnSourceChange($e:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, hnEnterFrame);
			
			clear();
			
			__makerBd = null;
			
			__stream.play(__source, 0);
			
			var soundTransform:SoundTransform = __stream.soundTransform || new SoundTransform();
			soundTransform.volume = 0;
			__stream.soundTransform = soundTransform;
			
			__stream.pause();
		}
		
		
		/**
		 * 
		 */
		private function netStatusHandler($e:NetStatusEvent):void
		{
			if($e.target == __connection)	__connection.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			
			var code:String = $e.info.code;
			//trace("code", code)
			switch (code)
			{
				case "NetStream.Play.StreamNotFound":
					dispatchEvent(new Event(VideoEventType.NOT_SUPPORTED_VIDEO));
					break;
				case "NetStream.Play.Start":
					dispatchEvent(new Event(VideoEventType.SUPPORTED_VIDEO));
					break;
			}
		}
	}
}