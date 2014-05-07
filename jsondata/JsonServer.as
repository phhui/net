package core.net.jsondata
{
	import core.manager.LogMgr;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	
	public class JsonServer
	{
		static private var urlLoader:URLLoader = new URLLoader();
		public function JsonServer()
		{
		}
		static public function load(url:String,callBack:Function,param:Object=null,ioErrFunc:Function=null,securityErrFunc:Function=null):void{
			var urlRequest:URLRequest = new URLRequest(url); //接收数据。
			urlRequest.method = URLRequestMethod.POST;
			if(param!=null){
				var urlVariables:URLVariables = new URLVariables();
				var str:String="";
				for(var i:String in param){
					urlVariables[i]=param[i];
					//str+="&&"+i+"="+param[i];
				}
				urlVariables.json =analyticalParam(param);//str.substr(2);
				urlRequest.data = urlVariables;
			}
			LogMgr.log("JSON请求数据："+url+" 参数："+(urlRequest.data?urlRequest.data.json:""));
			urlLoader.load(urlRequest);//这里是你要获取JSON的路径
			urlLoader.addEventListener(Event.COMPLETE, callBack);
			if(ioErrFunc!=null)urlLoader.addEventListener(IOErrorEvent.IO_ERROR,ioErrFunc);
			if(securityErrFunc!=null)urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrFunc);
		}
		static private function analyticalParam(obj:Object):String{
			var str:String="";
			for(var i:String in obj){
				if(obj[i] is String||obj[i] is Number||obj[i] is int){
					str+="&&"+i+"="+obj[i];
				}else if(obj[i] is Array){
					str+="&&"+i+"="+obj[i].toString();
				}else{
					str+="&&"+i+"="+analyticalParam(obj[i]);
				}
			}
			return str.substr(2);
		}
	}
}