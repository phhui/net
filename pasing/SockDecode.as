package core.net.pasing
{
	import core.manager.LogMgr;
	
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import utils.ToolsBag;
	import core.net.utils.DataType;
	import core.net.utils.ReceiveVo;
	import core.net.SKey;
	
	

 	public class SockDecode
	{
		static private var dataTypeList:Array = ["", DataType.BYTE, DataType.INT, DataType.LONG, DataType.STRING, DataType.ARRAY, DataType.BYTE_ARRAY, DataType.SHORT];
		private static var packsize:int;
		private static var packetHeadSize:int=5;
		private static var key:int=2;
		private static var surplusByte:ByteArray=new ByteArray();
		public function SockDecode()
		{
		}
		static public function decode(byte:ByteArray,obj:ReceiveVo):void{
			if (packsize == 0 && byte.bytesAvailable >= packetHeadSize) {
				packsize = byte.readInt();
				key = byte.readByte();
				obj.key=key;
				obj.packContent=byte;
				obj.packsize=packsize;
			}
			if (packsize != 0) {
				if (byte.bytesAvailable >= (packsize - packetHeadSize)) {
					LogMgr.log("接收：{key:"+key+",包长："+packsize+",byte:"+ToolsBag.traceByte(byte));
					packsize = 0
					readByte(byte,obj); 
				} else {
					LogMgr.log("出现断包");
				}
			}
			if(byte.position < byte.length){
				LogMgr.log("***出现粘包***");
				decode(byte,obj);
			}
		}
		static public function readByte(byte:ByteArray,obj:ReceiveVo):void{
			var arr:Array=[];
			while (byte.position < byte.length) {
				ByteArrayTools.readData(byte,arr,dataTypeList);
			}
			if(!obj.receive)obj.receive={};
			arrToObj(arr,SKey.getMsgAttr(key),obj.receive);
			LogMgr.log("接收：{key:"+key+",body:"+JSON.stringify(obj.receive)+"}");
		}
		static private function arrToObj(arr:Array,att:Array,obj:Object):void{
			if(att==null||att.length<1){
				obj=arr;
				return;
			}
			var n:int=arr.length;
			var j:int=0;
			for(var i:int=0;i<n;i++){
				if(arr[i] is Array){
					var ary:Array=[];
					arrToObj(arr[i],[],ary);
					if(obj is Array)obj.push(ary);
					else obj[att[j]]=ary;
				}else{
					if(obj is Array)obj.push(arr[i]);
					else obj[att[j]]=arr[i];
				}
				j++;
			}
		}
	}
}