/**
 * 
 */
package com.minarto.data 
{
	import flash.utils.Dictionary;
	
	
	public class Bind 
	{
		protected const _valueDic:* = {}, _reservations:* = {};
		
		
		protected var _handlerDic:* = {};
		
		
		/**
		 * 값 설정 
		 * @param $key	바인딩 키
		 * @param $value	바인딩 값
		 */
		public function set($key:String, ...$values):void
		{
			_valueDic[$key] = $values;
			
			$values.unshift($key);
			evt.apply(this, $values);
		}
		
		
		/**
		 * 이벤트 발생
		 * @param $key	이벤트 키
		 * @param $values	이벤트 값
		 */
		public function evt($key:String, ...$values):void 
		{
			var dic:Dictionary = _handlerDic[$key], fn:*, a:Array;
			
			for (fn in dic)
			{
				fn.apply(null, $values.concat(dic[fn]));
			}
			
			if (!fn)
			{
				a = reservations[$key] || (reservations[$key] = []);
				a.push($values);
			}			
		}
		
		
		/**
		 * 바인딩 
		 * @param $key		바인딩 키
		 * @param $handler	바인딩 핸들러
		 */				
		public function add($key:String, $handler:Function, ...$args):void 
		{
			var dic:Dictionary = _handlerDic[$key] || (_handlerDic[$key] = new Dictionary(true));
			
			dic[$handler] = $args;
			
			delete	reservations[$key];
		}
		
		
		/**
		 * 바인딩 
		 * @param $key		바인딩 키
		 * @param $handler	바인딩 핸들러
		 * @param $args		바인딩 추가 인자
		 */				
		public function addPlay($key:String, $handler:Function, ...$args):void 
		{
			var a:Array = reservations[$key], l:int = a ? a.length - 1 : 0, i:uint, values:Array = $args.concat();
		
			values.unshift($key, $handler);
			add.apply(this, values);
			
			for (; i < l; ++i)
			{
				values = a[i];
				$handler.apply(null, values.concat($args));
			}

			if (values = _valueDic[$key])
			{
				$handler.apply(null, values.concat($args));
			}
		}
		
		
		/**
		 * 바인딩 해제
		 * @param $key	바인딩 키
		 * @param $handler	바인딩 핸들러
		 * 
		 */			
		public function del($key:String=null, $handler:Function=null):void 
		{
			var key:String, dic:Dictionary, fn:*;
			
			for (key in _handlerDic)
			{
				if (($key == key) || (!$key))
				{
					dic = _handlerDic[key];
					for(fn in dic)
					{
						if(($handler == fn) || (!$handler))
						{
							delete	dic[fn];
						}
					}
				}				
			}
		}
		
		
		/**
		 * 값을 가져온다 
		 * @param $key	바인딩키
		 * @return 바인딩 값
		 * 
		 */
		public function get($key:String):Array 
		{
			return	_valueDic[$key];
		}
		
		
		/**
		 * 값을 가져온다 
		 * @param $key		바인딩키
		 * @param $index	값 인덱스
		 * @return 바인딩 값
		 * 
		 */
		public function getAt($key:String, $index:uint=0):* 
		{
			arguments = _valueDic[$key];
			
			return	arguments ? arguments[$index] : undefined;
		}
	}
}
