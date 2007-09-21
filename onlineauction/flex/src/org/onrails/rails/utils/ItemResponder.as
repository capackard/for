package org.onrails.rails.utils
{
	import mx.rpc.IResponder;

	public class ItemResponder implements IResponder
	{
		
		public function ItemResponder(result:Function, fault:Function, token:Object=null)
		{
			super();
			_resultHandler = result;
			_faultHandler = fault;
			_token = token;
		}		
		
		public function result(data:Object):void
		{
			_token ? _resultHandler(data, _token) : _resultHandler(data);
		}
		
		public function fault(info:Object):void
		{
			_token ? _faultHandler(info, _token) : _faultHandler(info);			
		}
		
		private var _resultHandler:Function;
		private var _faultHandler:Function;
		private var _token:Object;		
		
	}
}