package com.flexonrails.outliner.business {
	
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.flexonrails.outliner.vo.OutlinePoint;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;
	
	public class OutlinePointsDelegate {
		
		private var responder:IResponder;
		private var service:RemoteObject
		
		public function OutlinePointsDelegate(responder:IResponder) {
			this.responder = responder;
			
			service = ServiceLocator.getInstance().getRemoteObject(Services.OUTLINE_POINTS_SERVICE);
		}
		
		public function findRootOutlinePoint():void {
			addResponder(service.find_root())
		}
		
		public function findById(pointId:Number):void {
			
		}
		
		public function save(point:OutlinePoint, parent:OutlinePoint=null):void {
			var args:Object = {outline_point:point}
			if (parent) {
				args["parentId"] = parent.id;
			}
			addResponder(service.save(args));
		}
		
		public function destroy(point:OutlinePoint):void {
			addResponder(service.destroy({id:point.id}));
		}
		
		private function addResponder(serviceCall:*):void {
			var token:AsyncToken = serviceCall;
			token.addResponder(responder);
		}
	}
}