package core.net.pasing
{
	import flash.utils.ByteArray;
	import core.net.SKey;

	public class SockEncode
	{
		public function SockEncode()
		{
		}
		static public function encode(key:int,arr:Array):ByteArray {
			var type:Array=SKey.getCmdType(key);
			var n:int=type.length;
			if(n!=arr.length)throw new Error("发送指令所带参数与配置数量不匹配！");
			var byte:ByteArray=new ByteArray();
			for (var i:int = 0; i < n; i++) {
				ByteArrayTools.writeData(byte, type[i], arr[i])
			}
			return byte;
		}
	}
}