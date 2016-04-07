package com.minarto.loader
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.URLRequest;
	

	/**
	 * @author minarto
	 */
	public class MLoader 
	{
		static private const _instance:MLoader = new MLoader;
		
		
		static public function getInstance():MLoader
		{
			return	_instance;
		}
		
		
		protected const urq:URLRequest = new URLRequest, reservations:Array = [];
		
		
		protected var allVars:*;
		
		
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
		 * 로드 삭제 
		 * @param $key
		 * @param $v
		 * 
		 */		
		public function del($key:String, $v:*):void
		{
			var i:uint = reservations.length, vars:*, loader:Loader, info:LoaderInfo, isLoaded:Boolean;
			
			while(i --)
			{
				vars = reservations[i];
				if (loader = vars.__loader__)
				{
					isLoaded = true;
				}
				if(vars[$key] == $v)
				{
					if (loader)
					{
						info = loader.contentLoaderInfo;
						info.removeEventListener(Event.COMPLETE, complete);
						info.removeEventListener(IOErrorEvent.IO_ERROR, error);
						
						loader.close();
						
						delete	vars.__loader__;
					}					
					
					reservations.splice(i, 1);
				}
			}
			
			if (isLoaded)
			{
				_checkAllComplete();
			}
		}
		
		
		/**
		 * 로드
		 * @param $vars
		 * 
		 */		
		public function load($vars:Object=null):void
		{
			var i:* = reservations.length, loader:Loader, info:LoaderInfo, key:String = "onProgress", fn:Function, fnParams:Array;
		
			if (!$vars)
			{
				$vars = { };
			}
			allVars = $vars;
			
			if(fn = $vars[key])
			{
				i = reservations.length;
				key += "Params";
				if (fnParams = $vars[key])
				{
					fnParams.unshift(0, i);
				}
				else
				{
					$vars[key] = fnParams = [0, i];
				}
				
				fn.apply(null, fnParams);
			}
			
			for(i in reservations)
			{
				$vars = reservations[i];
				
				delete	$vars.content;
				
				if (loader = $vars.__loader__)
				{
					loader.close();
				}
				else
				{
					$vars.__loader__ = loader = new Loader;
					info = loader.contentLoaderInfo;
					info.addEventListener(Event.COMPLETE, complete);
					info.addEventListener(IOErrorEvent.IO_ERROR, error);
				}

				urq.url = $vars.src;
				loader.load(urq);
			}
		}
		
		
		protected function complete($e:Event):void
		{
			var info:LoaderInfo = $e.target as LoaderInfo, loader:Loader, i:*, vars:*, content:DisplayObject
			, key:String = "onProgress", fn:Function = allVars[key], fnParams:Array, loadedCount:uint;
			
			info.removeEventListener(Event.COMPLETE, complete);
			info.removeEventListener(IOErrorEvent.IO_ERROR, error);
			
			content = info.content;
			loader = info.loader;
			
			for(i in reservations)
			{
				vars = reservations[i];
				if(vars.__loader__ == loader)
				{
					delete	vars.__loader__;
					vars.content = content;
					
					loadedCount = 0;
					for(i in reservations)
					{
						if (!reservations[i].__loader__)
						{
							++ loadedCount;
						}						
					}
					if (fn)
					{
						fnParams = allVars[key + "Params"];
						fnParams[0] = loadedCount;
						fnParams[1] = reservations.length;
						fn.apply(null, fnParams);
					}
					
					if (fn = vars[key = "onComplete"])
					{
						if (fnParams = vars[key + "Params"])
						{
							fnParams.unshift(content);
						}
						else
						{
							fnParams = [content];
						}
						fn.apply(null, fnParams);
					}
					
					_checkAllComplete();
					
					return;
				}
			}
		}
		
		
		/**
		 * io error 이벤트 핸들러 
		 * @param $e
		 * 
		 */		
		protected function error($e:IOErrorEvent):void 
		{
			var info:LoaderInfo = $e.target as LoaderInfo, loader:Loader, i:*, vars:*
			, key:String = "onProgress", fn:Function = allVars[key], fnParams:Array, loadedCount:uint;
			
			info.removeEventListener(Event.COMPLETE, complete);
			info.removeEventListener(IOErrorEvent.IO_ERROR, error);
			
			loader = info.loader;
			
			for(i in reservations)
			{
				vars = reservations[i];
				if(vars.__loader__ == loader)
				{
					delete	vars.__loader__;
					delete	vars.content;
					
					loadedCount = 0;
					for(i in reservations)
					{
						if (!reservations[i].__loader__)
						{
							++ loadedCount;
						}						
					}
					if (fn)
					{
						fnParams = allVars[key + "Params"];
						fnParams[0] = loadedCount;
						fnParams[1] = reservations.length;
						fn.apply(null, fnParams);
					}
					
					if (fn = vars[key = "onError"])
					{
						fn.apply(null, vars[key + "Params"]);
					}
					
					_checkAllComplete();
					
					return;
				}
			}
		}
		
		
		private function _checkAllComplete():void
		{
			var i:*, vars:*, key:String = "onComplete", fn:Function, fnParams:Array, a:Array;
			
			for(i in reservations)
			{
				vars = reservations[i];
				if (vars.__loader__)
				{
					return;
				}
			}
			
			if(fn = allVars[key])
			{
				a = reservations.concat();
				if(fnParams = allVars[key + "Params"])
				{
					fnParams.unshift(a);
				}
				else
				{
					fnParams = [a];
				}
				
				fn.apply(null, fnParams);
			}

			reservations.length = 0;
			allVars = null;
		}
	}
}
