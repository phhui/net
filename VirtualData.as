package core.net
{
	import core.evnet.EventEx;
	import core.evnet.EventMgr;
	
	import flash.utils.ByteArray;

	public class VirtualData
	{
		private var inst:VirtualData=new VirtualData();
		public function VirtualData()
		{
			
		}
		
		static public function createData(vo:Class=null):Array
		{
			var arr:Array=[];
			if(vo==null){
				for(var i:int=0;i<500;i++)arr.push(["a"+i,"b"+i,"c"+i,"d"+i,"e"+i,"f"+i,"g"+i,"h"+i,"i"+i,"j"+i,"k"+i,"l"+i,"m"+i,"n"+i,"o"+i,"p"+i,"q"+i,"r"+i,"s"+i,"t"+i,"u"+i,"v"+i,"w"+i,"x"+i,"y"+i,"z"+i]);
				return arr;
			}else{
				for(var k:int=0;k<500;k++){
					var v:Object=new vo();
					var b:ByteArray=new ByteArray();
					b.writeObject(v);
					b.position=0;
					var o:Object=b.readObject();
					for(var j:String in o){
						if(typeof(v[j])=="string")v[j]="abc"+j;
						else if(typeof(v[j]=="int"))v[j]=Math.random()*100;
						else v[j]="aaa";
					}
					arr.push(v);
				}
				return arr;
			}
		}
	}
}