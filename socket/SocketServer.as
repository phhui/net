package core.net.socket
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;

	public class SocketServer
	{
		private var sock:Socket=new Socket();
		private var con:Function;
		private var packsize:int=0;
		public function SocketServer()
		{
		}
		public function connect(ip:String,port:int,func:Function=null):void{
			sock.addEventListener(Event.CONNECT,connected);
			sock.addEventListener(ProgressEvent.SOCKET_DATA,receive);
			sock.addEventListener(IOErrorEvent.IO_ERROR,connectError);
			sock.addEventListener(Event.CLOSE,socketClose);
			sock.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityError);
			sock.connect(ip,port);
			if(func!=null)con=func;
		}
		
		protected function securityError(e:SecurityErrorEvent):void
		{
			callBack("未正确设置安全策略文件"+e.text+"\n注意：\n1、返回的策略文件IP和端口要正确。\n2、返回的策略文件结尾要加\\0否则无法正常解析");
		}
		public function send(byte:ByteArray):void{
			if(!sock.connected){
				callBack("发送数据失败，SOCKET通信未成功连接！");
				return;
			}
			sock.writeBytes(byte);
			sock.flush();
			callBack("socketSend: {packsize:"+byte.length+",package:"+traceByte(byte)+"}");
		}
		private function traceByte(b:ByteArray):String{
			var n:int=b.length;
			var str:String="";
			for(var i:int=0;i<n;i++)str+=b[i]+" ";
			return str;
		}
		protected function socketClose(e:Event):void
		{
			callBack("SOCKET已关闭");
		}
		
		protected function connectError(e:IOErrorEvent):void
		{
			callBack("socket连接失败"+e.text);
		}
		
		protected function receive(e:ProgressEvent):void
		{
			var byte:ByteArray=new ByteArray();
			sock.readBytes(byte);
			callBack("socketReceive:"+traceByte(byte));
			callBack(byte);
		}
		protected function connected(e:Event):void
		{
			callBack(1);
			callBack("连接成功");
		}
		protected function callBack(obj:Object):void{
			if(con!=null)con(obj);
		}
		public function get socket():Socket{
			return sock;
		}
	}
}