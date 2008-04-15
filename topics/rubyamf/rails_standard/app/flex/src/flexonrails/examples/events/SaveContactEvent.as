package flexonrails.examples.events {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flexonrails.examples.vo.Contact;

	public class SaveContactEvent extends CairngormEvent {
		
		public static const SAVE_CONTACT:String = "SAVE_CONTACT"
	
		public var contact:Contact;
	
		public function SaveContactEvent(contact:Contact) {
			super(SAVE_CONTACT);
			this.contact = contact;
		}
			
	}
}