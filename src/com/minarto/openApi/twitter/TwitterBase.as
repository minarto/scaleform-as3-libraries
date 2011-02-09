package com.minarto.openApi.twitter
{
	import com.dborisenko.api.twitter.TwitterAPI;
	import com.dborisenko.api.twitter.commands.status.UpdateStatus;
	import com.dborisenko.api.twitter.events.TwitterEvent;
	import com.dborisenko.api.twitter.net.TwitterOperation;
	import com.dborisenko.api.twitter.oauth.OAuthTwitterConnection;
	import com.dborisenko.api.twitter.oauth.events.OAuthTwitterEvent;
	
	import flash.events.Event;
	
	import com.minarto.events.CustomEvent;
	import com.minarto.events.DefaultEventDispatcher;
	import com.minarto.openApi.key.TWITTER_APIKEY;
	
	
	/**
	 * 
	 * @author Minarto
	 * 트위터 라이브러리 in actionscript - http://code.google.com/p/twitter-actionscript-api/
	 * dosc - http://dev.dborisenko.com/twitter-actionscript-api/docs/
	 * api docs - http://dev.dborisenko.com/twitter-actionscript-api/docs/commands-summary.html
	 * 
	 */	
	public class TwitterBase extends DefaultEventDispatcher
	{
		/**
		 * 
		 */		
		private var __twitterApi:TwitterAPI;
		public function get twitterApi():TwitterAPI
		{
			return	__twitterApi;
		}
		
		
		/**
		 * 
		 */		
		public function get connection():OAuthTwitterConnection
		{
			return	__twitterApi.connection;
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function authorize($consumerKey:String, $consumerSecret:String):void
		{
			connection.addEventListener(OAuthTwitterEvent.REQUEST_TOKEN_RECEIVED, hnRequestTokenReceived);
			connection.addEventListener(OAuthTwitterEvent.REQUEST_TOKEN_ERROR, dispatchEvent);
			connection.addEventListener(OAuthTwitterEvent.ACCESS_TOKEN_ERROR, dispatchEvent);
			connection.addEventListener(OAuthTwitterEvent.AUTHORIZED, hnAuthorized);
			connection.authorize($consumerKey, $consumerSecret);
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function grantAccess($pin:String):void
		{
			connection.addEventListener(OAuthTwitterEvent.AUTHORIZED, hnAuthorized);
			connection.grantAccess($pin);
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function setAccessToken($tockenKey:String, $tockenSecret:String):void
		{
			connection.setAccessToken($tockenKey, $tockenSecret);
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function get tockenKey():String
		{
			return	connection.accessToken.key;
		}
		
		
		/**
		 * 
		 * 
		 */		
		public function get tockenSecret():String
		{
			return	connection.accessToken.secret;
		}
		
		
		/**
		 * 
		 * @param $tocken
		 * @param $tokenSecret
		 * 
		 */		
		protected function hnRequestTokenReceived($e:OAuthTwitterEvent):void
		{
			dispatchEvent(new CustomEvent(CTwitterEvent.NEED_PINNUMBER, TWITTER_APIKEY.AUTHORIZE_URL + "?oauth_token=" + encodeURIComponent(connection.requestToken.key)));
		}
		
		
		/**
		 * 
		 * @param $e
		 * 
		 */		
		protected function hnAuthorized($e:OAuthTwitterEvent):void
		{
			connection.removeEventListener(OAuthTwitterEvent.REQUEST_TOKEN_RECEIVED, hnRequestTokenReceived);
			connection.removeEventListener(OAuthTwitterEvent.REQUEST_TOKEN_ERROR, dispatchEvent);
			connection.removeEventListener(OAuthTwitterEvent.ACCESS_TOKEN_ERROR, dispatchEvent);
			connection.removeEventListener(OAuthTwitterEvent.AUTHORIZED, dispatchEvent);
			
			dispatchEvent(new Event(OAuthTwitterEvent.AUTHORIZED));
		}
		
		
		/**
		 * 
		 * @param $tocken
		 * @param $tokenSecret
		 * 
		 */		
		public function setTocken($tocken:String, $tokenSecret:String):void
		{
			__twitterApi.connection.setAccessToken($tocken, $tokenSecret);
		}
		
		
		/**
		 * 
		 * @param $v
		 * 
		 */		
		public function get authorized():Boolean
		{
			return	__twitterApi.connection.authorized;
		}
		
		
		/**
		 * 
		 * @param $consumerKey
		 * @param $consumerSecret
		 * @param $pinNumber
		 * 
		 */		
		public function TwitterBase()
		{
			__twitterApi = new TwitterAPI();
			init();
		}
		
		
		override public function init():void
		{
			connection.addEventListener(OAuthTwitterEvent.REQUEST_TOKEN_RECEIVED, hnRequestTokenReceived);
			connection.addEventListener(OAuthTwitterEvent.REQUEST_TOKEN_ERROR, dispatchEvent);
			connection.addEventListener(OAuthTwitterEvent.ACCESS_TOKEN_ERROR, dispatchEvent);
			connection.addEventListener(OAuthTwitterEvent.AUTHORIZED, dispatchEvent);
		}
		
		
		override public function destroy():void
		{
			connection.removeEventListener(OAuthTwitterEvent.REQUEST_TOKEN_RECEIVED, hnRequestTokenReceived);
			connection.removeEventListener(OAuthTwitterEvent.REQUEST_TOKEN_ERROR, dispatchEvent);
			connection.removeEventListener(OAuthTwitterEvent.ACCESS_TOKEN_ERROR, dispatchEvent);
			connection.removeEventListener(OAuthTwitterEvent.AUTHORIZED, dispatchEvent);
		}
		
		
		/**
		 * 
		 * @param $str
		 * 
		 */		
		public function updateStatus($str:String, $inReplyToStatusId:String=null):void
		{
			var op:TwitterOperation = new UpdateStatus($str, $inReplyToStatusId);
			op.addEventListener(TwitterEvent.COMPLETE, complete);
			__twitterApi.post(op);
		}
		
		
		/**
		 * 
		 * @param $e
		 * 
		 */			
		protected function complete($e:TwitterEvent):void
		{
			var op:TwitterOperation = $e.target as TwitterOperation;
			op.removeEventListener(TwitterEvent.COMPLETE, complete);
			
			dispatchEvent($e);
		}
	}
}