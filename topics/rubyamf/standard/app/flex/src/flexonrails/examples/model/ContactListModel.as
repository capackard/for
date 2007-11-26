package flexonrails.examples.model {
	
	import com.adobe.cairngorm.CairngormError;
	import com.adobe.cairngorm.CairngormMessageCodes;
	
	import flexonrails.examples.vo.Contact;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class ContactListModel {
		
		private static var instance:ContactListModel;
		
		public var contactList:ArrayCollection;
		
		public var selectedContact:Contact;
		
		public function ContactListModel(init:Initializer) {
			if (!init) throw new CairngormError(CairngormMessageCodes.SINGLETON_EXCEPTION);
		}
		
		public static function getInstance():ContactListModel {
			if (!instance) {
				instance = new ContactListModel(new Initializer());
			}
			
			return instance;
		}
		
	}
}
class Initializer {}