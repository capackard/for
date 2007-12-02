package flexonrails.examples.business {
	
	import com.adobe.cairngorm.business.ServiceLocator;
	
	import flexonrails.examples.vo.Contact;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;
	
	public class ContactListDelegate {
		
		private var responder:IResponder;
		private var service:ServiceLocator = ServiceLocator.getInstance();
		private var contactListService:RemoteObject;
		
		public function ContactListDelegate(responder:IResponder) {
			this.responder = responder;
			contactListService = service.getRemoteObject('contactListService');
		}
		
		public function getContactList():void {
			var token:AsyncToken = contactListService.index();
			token.addResponder(responder);
		}
		
		public function save(contact:Contact):void {
			if (contact.id == 0) {
				return create(contact);
			}
			var token:AsyncToken = contactListService.update(contact);
			token.addResponder(responder);
		}
		
		public function create(contact:Contact):void {
			var token:AsyncToken = contactListService.create(contact);
			token.addResponder(responder);
		}
		
		public function remove(contact:Contact):void {
			var token:AsyncToken = contactListService.destroy(contact.id);
			token.addResponder(responder);
		}
		
	}
}