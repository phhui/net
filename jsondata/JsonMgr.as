package core.net.jsondata
{
	import core.ResUrl;
	import core.evnet.EventMgr;
	import core.evnet.SysEvent;
	import core.manager.LogMgr;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.getTimer;
	

	public class JsonMgr
	{
		static private var loadList:Array=[];
		static private var urlLoader:URLLoader = new URLLoader();
		static private var loading:Boolean=false;
		static private var currentLoadObj:Object={};
		static private var jm:JsonMgr=new JsonMgr();
		static private var st:Number=0;
		public function JsonMgr(){
			//地址迁移到ResUrl.as中
		}
		static public function getData(name:String,callBack:Function,param:Object=null):void{
			var u:String=ResUrl.getJsonUrl(name);
			if(u==null){
				LogMgr.log("Json_Error:"+name+"所指向的地址不存在！");
				if(name.indexOf("http:")==-1)return;
				else u=name;
			}
			if(loading)loadList.push({url:u,callBack:callBack,param:param});
			else{
				currentLoadObj={url:u,callBack:callBack,param:param};
				load();
			}
		}
		static private function load():void{
			loading=true;
			st=getTimer();
			JsonServer.load(currentLoadObj.url,dataComplete,currentLoadObj.param,dataLoadError,dataLoadError);
		}
		static private function dataLoadError(e:*):void{
			LogMgr.log("Json_Error:"+currentLoadObj.url+"数据读取失败！");
			loadNext();
		}
		protected static function dataComplete(e:Event):void	{
			LogMgr.log(currentLoadObj.url+"请求耗时："+(getTimer()-st)+"毫秒");
			var obj:Object; 
			LogMgr.log("接收到PHP返回数据："+unescape(e.target.data));
			try{
				obj=JSON.parse(unescape(e.target.data));
			}catch(err:Error){
				loadNext();
				throw new Error("PHP服务端返回数据格式错误！");
			}
			if(currentLoadObj.callBack!=null)currentLoadObj.callBack(obj);
			loadNext();
		}
		static private function loadNext():void{
			loading=false;
			if(loadList.length<1)return;
			currentLoadObj=loadList.shift();
			load();
		}
		
	}
}