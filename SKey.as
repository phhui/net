package core.net
{
	import core.net.utils.Key;
	
	public class SKey
	{
		static private var k:Key=new Key();
		static private var sk:SKey=new SKey();//初始化数据
		public function SKey(){
			cmdList();
			msgList();
		}
		/**发送指令及类型列表**/		
		static private function cmdList():void{
			k.cmd[100]="string,long,string,byte";//登录  id,key,name
			k.cmd[101]="long,string";//私聊
			k.cmd[102]="string";//社区聊天
			k.cmd[103]="long,byte,long,byte";//装扮
			k.cmd[104]="byte,long,string,long,int,byte,int,int,int";//装扮物品
		}
		/**接收字段列表**/
		static private function msgList():void{
			k.attr[1]=["a1","a2","a3","a4","a5","a6"];
			k.attr[2]=["id","usn","sex","msg"];//私聊
			k.attr[3]=["id","usn","sex","msg"];//社区聊天
			k.attr[4]=["type","arr"];//装扮列表
			k.attr[5]=["state", "role"];
		}
	
		 static public function getCmdType(key:int):Array{
			 return k.getCmdType(key);
		 }
		 static public function getMsgAttr(key:int):Array{
			 return k.getMsgAttr(key);
		 }
	}
}