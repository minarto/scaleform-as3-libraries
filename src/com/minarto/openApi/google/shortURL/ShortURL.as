package com.minarto.openApi.google.shortURL
{
	import com.adobe.serialization.json.JSON;
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	import com.minarto.IDefaultInterface;
	
	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public final class ShortURL extends URLLoader implements IDefaultInterface
	{
		/**
		 * 
		 */		
		private const API_URL:String = "https://www.googleapis.com/urlshortener/v1/url";
		
		
		/**
		 * 
		 */		
		private var request:URLRequest;
		
		
		/**
		 * 
		 * 
		 */		
		public function ShortURL($apiKey:String)
		{
			request = new URLRequest(API_URL + "?key=" + $apiKey);
			request.method = URLRequestMethod.POST;
			request.contentType = "application/json";
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
			try
			{
				close();
			}
			catch(error:Error)	{}
		}
		
		
		/**
		 * 
		 * @param $url
		 * 
		 */		
		public function url($url:String):void
		{
			request.data = JSON.encode({longUrl:$url});
			load(request);
		}
		
		
		/**
		 * 
		 * @return 
		 * 
		 */			
		public function get shortURL():String
		{
			return	JSON.decode(data).id;
		}
		
		
		/**
		 * 
		 * @return 
		 * 
		 */			
		public function get qrCode():String
		{
			return	shortURL + ".qr";
		}
	}
}