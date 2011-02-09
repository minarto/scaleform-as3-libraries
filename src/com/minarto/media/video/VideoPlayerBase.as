package com.minarto.media.video
{
	import flash.events.*;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.*;
	
	import com.minarto.IDefaultInterface;
	import com.minarto.events.VideoEventType;
	

	/**
	 */
	public class VideoPlayerBase extends Video implements IDefaultInterface
	{
		/**
		 * 
		 */		
		protected var __stream:NetStream;
		public function get stream():NetStream
		{
			return	__stream;
		}
		
		
		/**
		 * 영상 소스
		 */		
		private var __source:String;
		public function set source($v:String):void
		{
			__source = $v;
			dispatchEvent(new Event(VideoEventType.SOURCE_CHANGE));
		}
		public function get source():String
		{
			return	__source;
		}
		
		
		/**
		 * 
		 */		
		private var __volume:Number = 1;
		public function set volume($v:Number):void
		{
			if($v == volume)	return;
			__volume = $v;
			var soundTransform:SoundTransform = __stream.soundTransform || new SoundTransform();
			soundTransform.volume = __volume;
			__stream.soundTransform = soundTransform;
		}
		public function get volume():Number
		{
			return	__volume;
		}
		
		
		/**
		 * 
		 */		
		private var __connection:NetConnection;
		
		
		/**
		 */
		public function VideoPlayerBase()
		{
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
			
			addEventListener(VideoEventType.SOURCE_CHANGE, hnSourceChange);
		}
		
		
		/**
		 * 
		 */		
		public function destroy():void
		{
			clear();
			
			__connection.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			__stream.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			removeEventListener(VideoEventType.SOURCE_CHANGE, hnSourceChange);
			
			__connection = null;
			
			try
			{
				__stream.close();
			}
			catch(error:Error)	{}
		}
		
		
		/**
		 * 
		 * @param $info
		 * 
		 */		
		public function onMetaData($info:Object):void
		{
			__duration = $info.duration;
		}
		
		
		/**
		 * 
		 */
		protected function hnSourceChange($e:Event):void
		{
			__stream.play(__source, 0);
			var soundTransform:SoundTransform = __stream.soundTransform || new SoundTransform();
			soundTransform.volume = __volume;
			__stream.soundTransform = soundTransform;
		}
		
		
		/**
		 * 
		 */
		private function netStatusHandler($e:NetStatusEvent):void
		{
			if(__connection == $e.target)	__connection.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);

			var code:String = $e.info.code;
			//trace("code", code)
			switch (code)
			{
				case "NetStream.Play.StreamNotFound":
					dispatchEvent(new Event(VideoEventType.NOT_SUPPORTED_VIDEO));
					break;
				case "NetStream.Play.Stop":
					if(Math.abs(duration - __stream.time) < 1)	dispatchEvent(new Event(VideoEventType.PLAY_COMPLETE));
					break;
				case "NetStream.Play.Start":
					dispatchEvent(new Event(VideoEventType.SUPPORTED_VIDEO));
					break;
            }
		}
		
		
		/**
		 * 
		 */
		public function seek($v:Number):void
		{
			__stream.seek($v || 0);
		}
		
		
		/**
		 * 
		 */
		public function get bytesLoaded():uint
		{
			return	__stream.bytesLoaded;
		}
		
		
		/**
		 * 
		 */
		public function get bytesTotal():uint
		{
			return	__stream.bytesTotal;
		}
		
		
		/**
		 * 총 재생시간
		 */
		private var __duration:Number;
		public function get duration():Number
		{
			return	__duration;
		}
		
		
		/**
		 * 재생
		 */
		public function play():void
		{
			__stream.resume();
		}
		
		
		/**
		 * 일시정지
		 */
		public function pause():void
		{
			__stream.pause();
		}
		
		
		/**
		 * 정지
		 */
		public function stop():void
		{
			pause();
			__stream.seek(0);
			clear();
		}
	}
}