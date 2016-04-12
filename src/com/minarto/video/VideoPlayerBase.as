package com.minarto.video
{
	import flash.events.*;
	import flash.media.*;
	import flash.net.*;

	/**
	 */
	public class VideoPlayerBase extends Video
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
		 * 
		 */		
		protected var __volume:Number = 1;
		
		public function setVolume($v:Number):void
		{
			var soundTransform:SoundTransform;
			
			if ($v == volume)
			{
				return;
			}
			__volume = $v;
			soundTransform = __stream.soundTransform || new SoundTransform;
			soundTransform.volume = $v;
			__stream.soundTransform = soundTransform;
		}
		public function getVolume():Number
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
			__connection = new NetConnection;
			__connection.connect(null);
			__connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			
			__stream = new NetStream(__connection);
			__stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			__stream.client = this;
			attachNetStream(__stream);
		}
		
		
		/**
		 * 
		 */		
		public function destroy():void
		{
			clear();
			
			__connection.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			__stream.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			
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
		
		
		protected var _src:String;
		/**
		 * 
		 */
		public function setSource($src:String):void
		{
			var soundTransform:SoundTransform = __stream.soundTransform || new SoundTransform;
			
			__stream.play($src, 0);
			
			soundTransform.volume = __volume;
			__stream.soundTransform = soundTransform;
		}
		public function getSource():String
		{
			return	_src;
		}
		
		
		/**
		 * 
		 */
		private function netStatusHandler($e:NetStatusEvent):void
		{
			var code:String = $e.info.code;
			
			if (__connection == $e.target)
			{
				__connection.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			}

			switch (code)
			{
				case "NetStream.Play.Stop":
					if (Math.abs(duration - __stream.time) < 1)
					{
						dispatchEvent(new Event(Event.COMPLETE));
					}
					break;
					
				default :
					dispatchEvent(new Event(code));
            }
		}
		
		
		/**
		 * 
		 */
		public function setSeek($v:Number):void
		{
			__stream.seek($v || 0);
		}
		public function getSeek():Number
		{
			__stream.seek;
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