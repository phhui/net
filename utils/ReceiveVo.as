package core.net.utils
{
	import flash.utils.ByteArray;
	
	import utils.ToolsBag;

	public class ReceiveVo
	{
		public var key:int;
		public var packsize:int;
		public var receive:Object;
		private var _packContent:ByteArray;
		public function ReceiveVo()
		{
		}

		public function get packContent():ByteArray
		{
			return _packContent;
		}

		public function set packContent(value:ByteArray):void
		{
			_packContent = value;
		}
		public function get packContentString():String{
			return ToolsBag.traceByte(_packContent);
		}

	}
}