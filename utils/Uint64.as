package core.net.utils {
	
	public class Uint64 {
		private var _uints:Vector.<uint>;
		private var _string16:String;
		private var _string10:String;
		private var _number:Number
		
		public function Uint64(uint1:uint = 0, uint2:uint = 0) {
			_uints = new Vector.<uint>;
			setForInt(uint1, uint2);
		}
		
		public function toString():String {
			return decimalLocation
		}
		
		public function toJSON(k:String):* {
			return _string10
		}
		
		public function get uints():Vector.<uint> {
			return _uints
		}
		
		public function get hexadecimal():String {
			return _string16
		}
		
		public function get decimalLocation():String {
			return _string10
		}
		
		public function setForInt(uint1:uint, uint2:uint):void {
			_uints[0] = uint1;
			_uints[1] = uint2;
			_number = uint1 * (uint.MAX_VALUE + 1) + uint2;
			if (uint1 > 0) {
				_string16 = uint1.toString(16) + repair(uint2.toString(16), 8);
				var precision:Number = (((uint1 % 100000) * (uint.MAX_VALUE + 1) % 100000) + uint2) % 10000
				_string10 = Math.floor(_number / 10000).toString() + precision.toString();
			} else {
				_string16 = uint2.toString(16);
				_string10 = uint2.toString();
			}
		}
		
		private function repair(value:String, long:int):String {
			for (var i:int = 0; i < long - value.length; i++) {
				value = "0" + value;
			}
			return value
		}
		
		public function setFor16(value:String):void {
			//setForInt(uint1, uint2);
			if (value.length > 8) {
				var uint1:uint = parseInt(value.slice(value.length - 16, value.length - 8), 16)
				var uint2:uint = parseInt(value.slice(value.length - 8, value.length), 16)
				setForInt(uint1, uint2);
			} else {
				//setForInt(0, parseInt(value, 10));
				setForInt(0, parseInt(value, 16));
			}
		}
		
		public function setFor10(value:String):void {
			if (value.length > 10) {
				var uint1:Number = parseInt(value.slice(0, value.length - 10), 10)
				var uint2:Number = parseInt(value.slice(value.length - 10, value.length), 10)
				setFor16(com(uint1, uint2))
			} else {
				setForInt(0, parseInt(value, 10));
			}
		}
		
		private function com(a:Number, b:Number):String {
			var n:Number = (a % 16 * Math.pow(10, 10) + b)
			var m:Number = n % 16
			if (a >= 16 || b >= 16) {
				return com(Math.floor(a / 16), Math.floor(n / 16)) + m.toString(16);
			} else {
				return m.toString(16);
			}
		}
		
		public function get number():Number {
			return _number;
		}
		
		public function set number(value:Number):void {
			//_number = value;
			setFor10(value.toString(10));
		}
	}
}