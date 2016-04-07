package com.minarto.loader
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.URLRequest;
	
	
	/**
	 * @author minarto
	 */
	public class SLoader 
	{
		static private const _instance:SLoader = new SLoader;
		
		
		static public function getInstance():SLoader
		{
			return	_instance;
		}
		
		
		protected const urq:URLRequest = new URLRequest, reservations:Array = [], contents:Array = [];
		
		
		protected var allVars:*, loader:Loader, currentVars:*;
		
		
		/**
		 * 로드 
		 * @param $src
		 * @param $vars
		 * @return 
		 * 
		 */		
		public function add($src:String, $vars:Object=null):void
		{
			if(!$vars)
			{
				$vars = {};
			}
			$vars.src = $src;
			
			reservations.push($vars);
		}
		
		
		/**
		 * 로드 id로 삭제 
		 * @param $loadID
		 * 
		 */		
		public function del($key:String, $v:*):void
		{
			var i:uint = reservations.length, info:LoaderInfo;
			
			while(i --)
			{
				if(reservations[i][$key] == $v)
				{
					reservations.splice(i, 1);
				}
			}
			
			i = contents.length;
			while(i --)
			{
				if(contents[i][$key] == $v)
				{
					contents.splice(i, 1);
				}
			}
			
			if (currentVars && (currentVars[$key] == $v))
			{
				info = loader.contentLoaderInfo;
				info.addEventListener(Event.COMPLETE, complete);
				info.addEventListener(IOErrorEvent.IO_ERROR, error);
				
				_load();
			}
		}
		
		
		/**
		 * 로드
		 * @param $complete
		 * @param $vars
		 * 
		 */		
		public function load($vars:Object=null):void
		{
			var key:String = "onProgress", fn:Function, fnParams:Array, l:uint;
			
			if (!$vars)
			{
				$vars = {};
			}
			allVars = $vars;
			
			if (fn = $vars[key])
			{
				key += "Params";
				l = reservations.length;
				if (fnParams = $vars[key])
				{
					fnParams.unshift(0, l);
				}
				else
				{
					$vars[key] = fnParams = [0, l];
				}
				fn.apply(null, fnParams);
			}
			
			_load();
		}
		
		
		protected function complete($e:Event):void
		{
			var info:LoaderInfo = $e.target as LoaderInfo, content:DisplayObject = info.content
			, key:String = "onProgress", fn:Function = allVars[key], fnParams:Array, cnt:uint = contents.push(content);
			
			info.removeEventListener(Event.COMPLETE, complete);
			info.removeEventListener(IOErrorEvent.IO_ERROR, error);
			
			if(fn)
			{
				fnParams = allVars[key + "Params"];
				fnParams[0] = cnt;
				fnParams[1] = cnt + reservations.length;
				fn.apply(null, fnParams);
			}
			
			if (fn = currentVars[key = "onComplete"])
			{
				if (fnParams = currentVars[key + "Params"])
				{
					fnParams.unshift(content);
					fn.apply(null, fnParams);
				}
				else
				{
					fn(content);
				}
			}
			
			_load();
		}
		
		
		/**
		 * io error 이벤트 핸들러 
		 * @param $e
		 * 
		 */		
		protected function error($e:IOErrorEvent):void 
		{
			var info:LoaderInfo = $e.target as LoaderInfo
			, key:String = "onProgress", fn:Function = allVars[key], fnParams:Array, cnt:uint = contents.push(undefined);
			
			info.removeEventListener(Event.COMPLETE, complete);
			info.removeEventListener(IOErrorEvent.IO_ERROR, error);
			
			if(fn)
			{
				fnParams = allVars[key + "Params"];
				fnParams[0] = cnt;
				fnParams[1] = cnt + reservations.length;
				fn.apply(null, fnParams);
			}
			
			if (fn = currentVars[key = "onError"])
			{
				fn.apply(null, currentVars[key + "Params"]);
			}
			
			_load();
		}
		
		
		protected function _load():void 
		{
			var info:LoaderInfo, key:String = "onComplete", fn:Function, fnParams:Array, a:Array;
			
			if(currentVars = reservations.shift())
			{
				urq.url = currentVars.src;
				
				loader = new Loader;
						
				info = loader.contentLoaderInfo;
				info.addEventListener(Event.COMPLETE, complete);
				info.addEventListener(IOErrorEvent.IO_ERROR, error);
				
				loader.load(urq);
			}
			else
			{
				if (fn = allVars[key])
				{
					a = contents.concat();
					if (fnParams = allVars[key + "Params"])
					{
						fnParams.unshift(a);
					}
					else
					{
						fnParams = [a];
					}
					fn.apply(null, fnParams);
				}
				
				contents.length = 0;
				reservations.length = 0;
				allVars = null;
				loader = null;
			}
		}
	}
}
