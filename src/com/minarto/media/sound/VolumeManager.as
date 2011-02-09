package com.minarto.media.sound
{
	import flash.events.Event;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	
	import com.minarto.events.DefaultEventDispatcher;
	import com.minarto.events.SoundEventType;
	
	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class VolumeManager extends DefaultEventDispatcher
	{
		/**
		 * 
		 */		
		private var __volume:Number = 1;
		public function set volume($v:Number):void
		{
			if(volume == $v)	return;
			__volume = $v;
			dispatchEvent(new Event(SoundEventType.VOLUME_CHANGE));
		}
		public function get volume():Number
		{
			return	__volume;
		}
		
		
		override public function init():void
		{
			addEventListener(SoundEventType.VOLUME_CHANGE, hnVolumeChange);
		}
		
		
		override public function destroy():void
		{
			removeEventListener(SoundEventType.VOLUME_CHANGE, hnVolumeChange);
		}
		
		
		/**
		 * 
		 * 
		 */		
		private function hnVolumeChange($e:Event):void
		{
			SoundMixer.soundTransform = new SoundTransform(__volume);
		}
	}
}