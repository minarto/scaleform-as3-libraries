package com.minarto.media.video
{
	import flash.events.*;
	import flash.media.SoundTransform;
	import flash.net.*;
	
	import com.minarto.events.CustomEvent;
	import com.minarto.events.VideoEventType;
	

	/**
	 */
	public class VideoPlayer extends VideoPlayerBase
	{
		/**
		 * 
		 */		
		public var autoPlay:Boolean = true;
		public var autoRewind:Boolean = false;
		
		
		/**
		 * 
		 */		
		private var __muted:Boolean;
		public function set muted($v:Boolean):void
		{
			if($v == muted)	return;
			__muted = $v;
			var soundTransform:SoundTransform = stream.soundTransform || new SoundTransform();
			soundTransform.volume = __muted ? 0 : __volume;
			stream.soundTransform = soundTransform;
		}
		public function get muted():Boolean
		{
			return	__muted;
		}
		
		
		/**
		 * 
		 */		
		private var __volume:Number = 1;
		override public function set volume($v:Number):void
		{
			if($v == volume)	return;
			__volume = $v;
			var soundTransform:SoundTransform = __stream.soundTransform || new SoundTransform();
			soundTransform.volume = muted ? 0 : __volume;
			__stream.soundTransform = soundTransform;
		}
		override public function get volume():Number
		{
			return	__volume;
		}
		
		
		/**
		 * 
		 */		
		private var __playing:Boolean;
		public function get playing():Boolean
		{
			return	__playing;
		}
		
		
		override public function destroy():void
		{
			super.destroy();

			removeEventListener(VideoEventType.PLAY_COMPLETE, hnPlayComplete);
		}
		
		
		override public function onMetaData($info:Object):void
		{
			super.onMetaData($info);
			dispatchEvent(new CustomEvent(VideoEventType.ON_METADATA, $info));
		}
		
		
		/**
		 * 
		 */
		private function hnPlayComplete($e:Event):void
		{
			if(autoRewind)	stream.seek(0);
		}
		
		
		override protected function hnSourceChange($e:Event):void
		{
			addEventListener(VideoEventType.PLAY_COMPLETE, hnPlayComplete);
			super.hnSourceChange($e);
			
			var soundTransform:SoundTransform = __stream.soundTransform;
			soundTransform.volume = muted ? 0 : __volume;
			stream.soundTransform = soundTransform;
			
			if(autoPlay)
			{
				__playing = true;
			}
			else
			{
				__playing = false;
				stream.pause();
			}
		}
		
		
		/**
		 * 현재 재생시간
		 */
		private var __currentTime:Number = 0;
		public function get currentTime():Number
		{
			__currentTime = __stream.time;
			return	__currentTime;
		}
		
		
		override public function play():void
		{
			super.play();
			__playing = true;
			
			addEventListener(VideoEventType.PLAY_COMPLETE, hnPlayComplete);
		}
		
		
		override public function pause():void
		{
			super.pause();
			__playing = false;

			removeEventListener(VideoEventType.PLAY_COMPLETE, hnPlayComplete);
		}
	}
}