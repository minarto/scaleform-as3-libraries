package com.minarto.airApp.display
{
	import com.codeazur.utils.AIRRemoteUpdater;
	import com.codeazur.utils.AIRRemoteUpdaterEvent;
	
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.ui.Mouse;
	import flash.utils.Timer;

	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class AppMainBase extends AppContainer
	{
		/**
		 * 
		 */		
		protected var idleTimer:Timer;
		
		
		/**
		 * 
		 */		
		public var version:String = "1.0";
		
		
		/**
		 * 
		 * 
		 */		
		public function AppMainBase()
		{
			super();
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			Mouse.hide();
			
			tabChildren = false;
			tabEnabled = false;
		}
		
		
		/**
		 * 
		 * 
		 */		
		protected function update($airUrl:String):void
		{
			var request:URLRequest = new URLRequest($airUrl);
			var updater:AIRRemoteUpdater = new AIRRemoteUpdater();
			updater.addEventListener(AIRRemoteUpdaterEvent.VERSION_CHECK, updaterVersionCheckHandler);
			updater.addEventListener(AIRRemoteUpdaterEvent.UPDATE, updaterUpdateHandler);
			updater.addEventListener(IOErrorEvent.IO_ERROR, hnUpdateError);
			updater.addEventListener(SecurityErrorEvent.SECURITY_ERROR, hnUpdateError);
			updater.update(request);
		}
		
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function hnUpdateError($e:Event):void
		{
			
		}
		
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function updaterVersionCheckHandler(event:AIRRemoteUpdaterEvent):void
		{
			var updater:AIRRemoteUpdater = event.target as AIRRemoteUpdater;
			updater.removeEventListener(AIRRemoteUpdaterEvent.VERSION_CHECK, updaterVersionCheckHandler);
			
			trace("Local version: " + updater.localVersion);
			trace("Remote version: " + updater.remoteVersion);
		}
		
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function updaterUpdateHandler(event:AIRRemoteUpdaterEvent):void
		{
			var updater:AIRRemoteUpdater = event.target as AIRRemoteUpdater;
			updater.removeEventListener(AIRRemoteUpdaterEvent.UPDATE, updaterUpdateHandler);
			updater.removeEventListener(IOErrorEvent.IO_ERROR, hnUpdateError);
			updater.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, hnUpdateError);
			
			trace("Installer: " + event.file.nativePath);
		}
		
		
		/**
		 * 
		 * 
		 */		
		protected function hnConfigLoadComplete($e:Event):void
		{
		}
		
		
		/**
		 * 
		 * 
		 */		
		protected function hnIdleTimerComplete($e:TimerEvent):void
		{
			hnChildAppPrevChange();
		}
	}
}