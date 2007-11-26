package flexonrails.examples.control {
	
	import com.adobe.cairngorm.control.FrontController;
	
	import flexonrails.examples.commands.*;
	import flexonrails.examples.events.*;

	public class ContactListController extends FrontController {
		
		public function ContactListController() {
			init();
		}
		
		public function init():void {
			addCommand(LoadContactListEvent.LOAD_CONTACT_LIST, LoadContactListCommand);
			addCommand(SaveContactEvent.SAVE_CONTACT, SaveContactCommand);
			addCommand(RemoveContactEvent.REMOVE_CONTACT, RemoveContactCommand);
		}
		
	}
}