package core.net.jsCall
{
	import core.manager.LogMgr;
	
	import flash.external.ExternalInterface;

	public class JSConnectMgr
	{
		public function JSConnectMgr()
		{
		}
		static public function callJs(funcName:String,param:String,callBackName:String=null,callBack:Function=null):* { 
			//判断是否是有效的引用
			if (ExternalInterface.available) { 
				//把方法写入容器可调用
				if(callBackName!=null&&callBack!=null){
					ExternalInterface.addCallback(callBackName, callBack);
				}
				//调用JS里面的方法
				return ExternalInterface.call(funcName,param); 
				LogMgr.log("调用JS方法："+funcName+" 参数："+param+" 回调方法："+callBackName);
			}
			return null;
		}
		static public function addListen(name:String,callBack:Function):void{
			ExternalInterface.addCallback(name, callBack);
		}
	}
}