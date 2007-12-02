package flexonrails.examples.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flexonrails.examples.business.ContactListDelegate;
	import flexonrails.examples.model.ContactListModel;
	import flexonrails.examples.vo.Contact;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;

	public class LoadContactListCommand implements ICommand, IResponder {
		
		private var model:ContactListModel = ContactListModel.getInstance();
		
		public function execute(event:CairngormEvent):void {
			var delegate:ContactListDelegate = new ContactListDelegate(this);
			delegate.getContactList();
		}
		
		public function result(data:Object):void {
			var re:ResultEvent = data as ResultEvent;
			model.contactList = re.result as ArrayCollection;
		}
		
		public function fault(info:Object):void {
			Alert.show("Unable to retrieve contact list");
		}
		
	}
}