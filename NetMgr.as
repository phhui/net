package core.net
{
	import core.net.jsCall.JSConnectMgr;
	import core.net.jsondata.JsonMgr;
	import core.net.socket.SockMgr;

	public class NetMgr
	{
		public function NetMgr(){
		}
		/**Socket发送数据**/
		static public function socketSend(key:int,param:Array=null):void{
			SockMgr.send(key,param);
		}
		/**socket接收数据**/
		static public function socketReceive(key:int,callBack:Function):void{
			SockMgr.receive(key,callBack);
		}
		/**JSON发送接收数据**/
		static public function jsonLoad(name:String,callBack:Function,param:Object=null):void{
			JsonMgr.getData(name,callBack,param);
		}
		/**
		 *与JS通信 
		 * @param funName 要调用的JS方法名字
		 * @param param 传给JS的参数
		 * @param callBackName 提供给JS调用的方法名字
		 * @param callBack 提供给JS调用的方法
		 * @return 返回JS返回的数据，String
		 * 
		 */		
		static public function callJs(funName:String,param:String,callBackName:String=null,callBack:Function=null):*{
			return JSConnectMgr.callJs(funName,param,callBackName,callBack);
		}
		/**
		 *监听JS调用
		 * @param name 调用名字（需要提供给JS页面用)
		 * @param callBack 调用方法
		 * 
		 */		
		static public function listenJsCall(name:String,callBack:Function):void{
			JSConnectMgr.addListen(name,callBack);
		}
	}
}