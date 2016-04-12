package com.minarto.media.video
{
	import flash.events.*;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.*;
	
	import com.minarto.events.CustomEvent;
	
	import org.osmf.events.TimeEvent;
	import com.minarto.events.VideoEventType;
	
	
	/**
	 */
	public class VideoThumbnail extends VideoPlayerBase
	{
		/**
		 * 
		 */		
		public var thumbNailTime:Number;
		
		
		/**
		 */
		public function VideoThumbnail()
		{
			super();
		}
		
		
		override public function onMetaData($info:Object):void
		{
			super.onMetaData($info);
			
			stream.seek(isNaN(thumbNailTime) ? uint(Math.random() * $info.duration) : thumbNailTime);
			dispatchEvent(new Event(VideoEventType.ON_METADATA));
		}
		
		
		override protected function hnSourceChange($e:Event):void
		{
			super.hnSourceChange($e);
			pause();
		}
	}
}