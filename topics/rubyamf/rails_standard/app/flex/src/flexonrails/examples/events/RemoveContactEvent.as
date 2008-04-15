package flexonrails.examples.events {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flexonrails.examples.vo.Contact;

	public class RemoveContactEvent extends CairngormEvent {
		
		public static const REMOVE_CONTACT:String = "REMOVE_CONTACT"
	
		public var contact:Contact
	
		public function RemoveContactEvent(contact:Contact) {
			super(REMOVE_CONTACT);
			this.contact = contact;
		}
			
	}
}