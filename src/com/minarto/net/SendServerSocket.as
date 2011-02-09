package com.minarto.net
{
	import flash.events.*;
	import flash.net.*;
	
	
	/**
	 * 
	 * @author UX
	 * 
	 */	
	public class SendServerSocket extends ServerSocket
	{
		private var socketList:Vector.<Socket> = new Vector.<Socket>();
		
		
		/**
		 * 
		 * 
		 */		
		public function SendServerSocket()
		{
			addEventListener(ServerSocketConnectEvent.CONNECT, connectHandler);
			addEventListener(Event.CLOSE, dispatchEvent);
		}
		
		
		/**
		 * 서버에 클라이언트 접속시 핸들러
		 * @param $e
		 * 
		 */
		private function connectHandler($e:ServerSocketConnectEvent):void
		{
			var socket:Socket = $e.socket as Socket;
			socket.addEventListener(ServerSocketConnectEvent.CONNECT, dispatchEvent);
            socket.addEventListener(Event.CLOSE, clientSocketClose);
            socket.addEventListener(IOErrorEvent.IO_ERROR, dispatchEvent);
            
            socketList.push(socket);
            
            dispatchEvent($e);
		}
		
		
		/**
		 * 
		 * @param $obj
		 * 
		 */		
		public function sendData($obj:Object):void
		{
			var socket:Socket;
            for each(socket in socketList)
            {
				socket.writeObject($obj);
				socket.flush();
            }
		}
		
		
		/**
		 * 
		 * @param $e
		 * 
		 */		
		private function clientSocketClose($e:Event):void
		{
			var socket:Socket = $e.target as Socket;
			socket.removeEventListener(ServerSocketConnectEvent.CONNECT, dispatchEvent);
            socket.removeEventListener(Event.CLOSE, clientSocketClose);
            socket.removeEventListener(IOErrorEvent.IO_ERROR, dispatchEvent);
            
			dispatchEvent($e);
		}
	}
}