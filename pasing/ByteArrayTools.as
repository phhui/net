package core.net.pasing
{
	import core.net.utils.DataType;
	import core.net.utils.Uint64;
	
	import flash.utils.ByteArray;

	public class ByteArrayTools
	{
		public function ByteArrayTools()
		{
		}
		/**
		 * 写入
		 * @param	byteArray
		 * @param	type
		 * @param	data
		 */
		static public function writeData(byteArray:ByteArray, type:Object, data:Object):void {
			switch (type) {
				case DataType.BYTE: 
					byteArray.writeByte(1);
					byteArray.writeByte(int(data));
					break;
				case DataType.INT: 
					byteArray.writeByte(2);
					byteArray.writeUnsignedInt(int(data));
					break;
				case DataType.LONG: 
					byteArray.writeByte(3);
					var uint64:Uint64;
					if(data is Number||data is String){
						uint64=new Uint64();
						uint64.number=Number(data);
					}else uint64=data as Uint64;
					byteArray.writeUnsignedInt(uint64.uints[0]);
					byteArray.writeUnsignedInt(uint64.uints[1]);
					break;
				case DataType.STRING: 
					byteArray.writeByte(4);
					var stringData:ByteArray = new ByteArray();
					stringData.writeUTFBytes(String(data));
					byteArray.writeByte(stringData.length);
					byteArray.writeBytes(stringData);
					break
				case DataType.BYTE_ARRAY: 
					byteArray.writeByte(6);
					var inArray:ByteArray = data as ByteArray;
					byteArray.writeUnsignedInt(inArray.length);
					byteArray.writeBytes(inArray);
					break;
				case DataType.SHORT: 
					byteArray.writeByte(7);
					byteArray.writeShort(int(data));
					break;
				case DataType.DOUBLE: 
					byteArray.writeByte(8);
					byteArray.writeDouble(Number(data));
					break;
			}
		}
		
		static public function readData(byteArray:ByteArray,arr:Array,typeArr:Array):void{
			var t:int=byteArray.readUnsignedByte();
			var type:String=typeArr[t];
			switch (type) {
				case DataType.BYTE: 
					arr.push(byteArray.readUnsignedByte());
					break;
				case DataType.INT: 
					arr.push(byteArray.readUnsignedInt());
					break;
				case DataType.LONG: 
					var uint64:Uint64 = new Uint64(byteArray.readUnsignedInt(), byteArray.readUnsignedInt())
					arr.push(uint64);
					break;
				case DataType.STRING: 
					var len:int = byteArray.readUnsignedByte();
					arr.push(byteArray.readUTFBytes(len));
					break;
				case DataType.ARRAY: 
					var arrayLen:int = byteArray.readUnsignedInt();
					var ar:Array=[];
					for (var i:int = 0; i < arrayLen; i++) {
						readData(byteArray,ar, typeArr)
					}
					arr.push(ar);
					break
				case 6: 
					arr.push(byteArray.readUnsignedInt() * (uint.MAX_VALUE + 1) + byteArray.readUnsignedInt());
					break;
				case 7: 
					arr.push(byteArray.readShort());
					break;
				case 8: 
					arr.push(byteArray.readDouble());
			}
		}
	}
}