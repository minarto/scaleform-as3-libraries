package com.minarto.openApi.nate.oauth
{
	import com.minarto.events.DefaultEventDispatcher;
	
	import flash.events.Event;
	import flash.html.HTMLLoader;
	import flash.media.StageWebView;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.navigateToURL;
	
	import org.iotashan.oauth.OAuthConsumer;
	import org.iotashan.oauth.OAuthRequest;
	import org.iotashan.oauth.OAuthSignatureMethod_HMAC_SHA1;
	import org.iotashan.oauth.OAuthToken;
	import org.iotashan.utils.OAuthUtil;
	
	
	/**
	 * 
	 * @author Minarto
	 * 
	 */	
	public class NateOauth extends DefaultEventDispatcher
	{
		/**
		 * 
		 */		
		private const getRequestTokenUrl:String = "https://oauth.nate.com/OAuth/GetRequestToken/V1a";
		private const authorizeUrl:String = "https://oauth.nate.com/OAuth/Authorize/V1a";
		private const getAccessTokenUrl:String = "https://oauth.nate.com/OAuth/GetAccessToken/V1a";
		private const getMemberUrl:String = "https://oauth.nate.com/OAuth/GetNateMemberInfo/V1a";
		
		private var uLoader:URLLoader;
		public var oauthTocken:OAuthToken;
		
		private var htmlLoader:HTMLLoader;
		private var stageWebView:StageWebView;
		private var signatureMethod:OAuthSignatureMethod_HMAC_SHA1;
		
		
		
		/**
		 * 
		 * 
		 */		
		public function NateOauth($htmlLoader:HTMLLoader=null, $stageWebView:StageWebView=null)
		{
			super();
			
			htmlLoader = $htmlLoader;
			stageWebView = $stageWebView;
			
			uLoader = new URLLoader();
			signatureMethod = new OAuthSignatureMethod_HMAC_SHA1();
		}
		
		
		/**
		 * 
		 * @param $consumerKey
		 * 
		 */		
		public function getRequestToken($consumerKey:String, $consumerSecret:String):void
		{
			var consumer:OAuthConsumer = new OAuthConsumer($consumerKey, $consumerSecret);
			
			var oRequest:OAuthRequest = new OAuthRequest("POST", getRequestTokenUrl, null, consumer, null);
			
			var request:URLRequest = new URLRequest(oRequest.buildRequest(signatureMethod));
			request.method = URLRequestMethod.POST;
			request.contentType = "application/x-www-form-urlencoded";
			
			uLoader.addEventListener(Event.COMPLETE, hnGetRequestTokenComplete);
			uLoader.load(request);
		}
		
		
		/**
		 * 
		 * @param $consumerKey
		 * 
		 */		
		private function hnGetRequestTokenComplete($e:Event):void
		{
			uLoader.removeEventListener(Event.COMPLETE, hnGetRequestTokenComplete);
			oauthTocken = OAuthUtil.getTokenFromResponse($e.target.data);
			trace("GetRequestToken : ", oauthTocken.key, oauthTocken.secret);
			authorize(oauthTocken);
		}
		
		
		/**
		 * 
		 * @param $oauthTocken
		 * 
		 */		
		public function authorize($oauthTocken:OAuthToken):void
		{
			var url:String = authorizeUrl + "?oauth_token=" + $oauthTocken.key;
			
			if(htmlLoader)
			{
				htmlLoader.load(new URLRequest(url));
			}
			else
			{
				stageWebView.loadURL(url);
			}
		}
		
		
		/**
		 * 
		 * @param $e
		 * 
		 */		
		public function getAccessToken($oauthVerifier:String, $consumerKey:String, $consumerSecret:String):void
		{
			var consumer:OAuthConsumer = new OAuthConsumer($consumerKey, $consumerSecret);
			
			var oRequest:OAuthRequest = new OAuthRequest("POST", getAccessTokenUrl, {oauth_verifier:$oauthVerifier}, consumer, oauthTocken);
			var request:URLRequest = new URLRequest(oRequest.buildRequest(signatureMethod));
			request.method = URLRequestMethod.POST;
			request.contentType = "application/x-www-form-urlencoded";
			
			uLoader.addEventListener(Event.COMPLETE, hnGetAccessTokenComplete);
			uLoader.load(request);
		}
		
		
		/**
		 * 
		 * @param $consumerKey
		 * 
		 */		
		private function hnGetAccessTokenComplete($e:Event):void
		{
			uLoader.removeEventListener(Event.COMPLETE, hnGetAccessTokenComplete);
			oauthTocken = OAuthUtil.getTokenFromResponse($e.target.data);
			trace("GetAccessToken : ", $e.target.data);
		}
		
		
		/**
		 * 
		 * @param $e
		 * 
		 */		
		public function getMemberList($oauthVerifier:String, $consumerKey:String, $consumerSecret:String):void
		{
			var consumer:OAuthConsumer = new OAuthConsumer($consumerKey, $consumerSecret);
			
			var obj:Object = {oauth_verifier:$oauthVerifier};
			var oRequest:OAuthRequest = new OAuthRequest("POST", getMemberUrl, null, consumer, oauthTocken);
			var request:URLRequest = new URLRequest(oRequest.buildRequest(signatureMethod));
			request.method = URLRequestMethod.POST;
			request.contentType = "application/x-www-form-urlencoded";
			
			uLoader.addEventListener(Event.COMPLETE, hnGetMemberComplete);
			uLoader.load(request);
		}
		
		
		/**
		 * 
		 * @param $consumerKey
		 * 
		 */		
		private function hnGetMemberComplete($e:Event):void
		{
			trace(uLoader.data);
		}
	}
}