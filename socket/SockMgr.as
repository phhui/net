package core.net.socket
{
	import core.evnet.EventEx;
	import core.evnet.EventInteraction;
	import core.evnet.EventMgr;
	import core.manager.LogMgr;
	import core.net.pasing.SockDecode;
	import core.net.pasing.SockEncode;
	import core.net.utils.ReceiveVo;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import utils.ToolsBag;
	import utils.json.JSON;

	public class SockMgr
	{
		static private var sock:SocketServer=new SocketServer();
		static private var packsizeHeader:int=5;
		static private var receiveList:Dictionary=new Dictionary();
		static private var connected:Function;
		public function SockMgr(){
		}
		static public function connect(callBack:Function=null):void{
			sock.connect(Conf.IP,Conf.port,contact);
			if(callBack!=null)connected=callBack;
		}
		static public function send(key:int,arr:Array=null):void{
			LogMgr.log("请求发送:{key:"+key+",body：{"+(arr?arr.toString():"null")+"}}");
			var byte:ByteArray=new ByteArray();
			if(arr!=null){
				var bodyByte:ByteArray=SockEncode.encode(key,arr);
				byte.writeUnsignedInt(bodyByte.length+packsizeHeader);
				byte.writeByte(key);
				byte.writeBytes(bodyByte);
			}else{
				byte.writeUnsignedInt(packsizeHeader);
				byte.writeByte(key);
			}
			sock.send(byte);
		}
		static public function receive(key:int,callBack:Function):void{
			if(receiveList[key])receiveList[key].push(callBack);
			else receiveList[key]=[callBack];
		}
		static private function contact(param:Object):void
		{
			if(param is String){
				LogMgr.log(String(param));
			}else if(param is ByteArray){
				var v:ReceiveVo=new ReceiveVo();
				SockDecode.decode(ByteArray(param),v);
				disReceive(v);
			}else if(param is int){
				if(param==1)connected();
			}
		}
		static private function disReceive(v:ReceiveVo):void{
			if(!receiveList[v.key]){
				LogMgr.log("***消息"+v.key+"未处理！***");
				return;
			}
			var n:int=receiveList[v.key].length;
			for(var i:int=0;i<n;i++){
				receiveList[v.key][i](v.receive);
			}
		}
		
		static public function get gameSocket():SocketServer
		{
			return sock;
		}
	}
}