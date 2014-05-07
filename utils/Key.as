package core.net.utils
{
	import flash.utils.Dictionary;

	public class Key
	{
		public var cmd:Dictionary=new Dictionary();
		public var attr:Dictionary=new Dictionary();
		public function Key()
		{
		}
		public function addType(key:int,arr:Array):void{
			cmd[key]=arr;
		}
		public function addAttr(key:int,arr:Array):void{
			attr[key]=arr;
		}
		public function getCmdType(key:int):Array{
			if(cmd[key] is String)return cmd[key].split(',');
			return setType(cmd[key]);
		}
		public function getMsgAttr(key:int):Array{
			if(attr[key] is String)return attr[key].split(',');
			return attr[key];
		}
		private function setType(arr:Array):Array{
			if(arr==null||arr.length<1)return null;
			var n:int=arr.length;
			for(var i:int=0;i<n;i++){
				if(arr[i] is String)arr[i]=replace(arr[i]);
				else if(arr[i] is Array) arr[i]=setType(arr[i]);
			}
			return arr;
		}
		private function replace(str:String):String{
			str=str.toLocaleLowerCase();
			str=str.replace("int",DataType.INT);
			str=str.replace("long",DataType.LONG);
			str=str.replace("string",DataType.STRING);
			str=str.replace("short",DataType.SHORT);
			str=str.replace("byte",DataType.BYTE);
			str=str.replace("double",DataType.DOUBLE);
			str=str.replace("bytearray",DataType.BYTE_ARRAY);
			return str;
		}
	}
}