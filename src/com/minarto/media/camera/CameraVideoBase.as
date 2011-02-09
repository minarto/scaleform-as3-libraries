package com.minarto.media.camera
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.media.Camera;
	import flash.media.Video;
	
	import com.minarto.IDefaultInterface;
	import com.minarto.events.CameraEventType;
	
	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class CameraVideoBase extends Video implements IDefaultInterface
	{
		/**
		 * 
		 */		
		private var __camera:Camera;
		public function get camera():Camera
		{
			return	__camera;
		}
		
		
		/**
		 * 
		 */		
		private var tempVideo:Video;
		private var tempVideoContainer:Sprite;
		
		
		/**
		 * 
		 */		
		private var __playing:Boolean;
		public function get playing():Boolean
		{
			return	__playing;
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function CameraVideoBase($name:String=null)
		{
			__camera = Camera.getCamera($name);
			
			tempVideoContainer = new Sprite();
			tempVideoContainer.mouseChildren = false;
			tempVideoContainer.mouseEnabled = false;
			
			tempVideo = new Video();
			tempVideoContainer.addChild(tempVideo);
			
			init();
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function init():void
		{
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function destroy():void
		{
			attachCamera(null);
			tempVideo.attachCamera(null);
			clear();
			tempVideo.clear();
			__camera = null;
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function setCamera($name:String=null):void
		{
			var f:Number = __camera ? __camera.fps : 0;
			__camera = Camera.getCamera($name);
			__camera.setMode(videoWidth, videoHeight, f || __camera.fps, true);
			if(__playing)	play();
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function play():void
		{
			if(Camera.isSupported)
			{
				__playing = true;
				attachCamera(__camera);
				tempVideo.attachCamera(__camera);
			}
			else
			{
				dispatchEvent(new Event(CameraEventType.NOT_SUPPORTED_CAMERA));
			}
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function pause():void
		{
			__playing = false;
			attachCamera(null);
			tempVideo.attachCamera(null);
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function stop():void
		{
			pause();
			clear();
			tempVideo.clear();
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function setMode($w:int, $h:int, $fps:int=0):void
		{
			__camera.setMode($w, $h, $fps || __camera.fps, true);
			tempBitmapData = new BitmapData($w, $h, true, 0x00FFFFFF);
			tempVideo.width = $w;
			tempVideo.height = $h;
		}
		
		
		/**
		 * 
		 */		
		private var tempBitmapData:BitmapData;
		
		
		/**
		 * 
		 * 
		 */		
		public function shutter():BitmapData
		{
			tempBitmapData.draw(tempVideoContainer);
			
			return	tempBitmapData;
		}
	}
}