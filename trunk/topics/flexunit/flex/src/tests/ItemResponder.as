package tests
{
	import mx.rpc.IResponder;
	
	public class ItemResponder implements IResponder {
		public function ItemResponder(result:Function, fault:Function){
			_resultHandler = result;
			_faultHandler = fault;
		}
		public function result(data:Object):void{
			_resultHandler(data);
		}
		public function fault(info:Object):void{
			_faultHandler(info);
		}
		private var _resultHandler:Function;
		private var _faultHandler:Function;		
	}
}