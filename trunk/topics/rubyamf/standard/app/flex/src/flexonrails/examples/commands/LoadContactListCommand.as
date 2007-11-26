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
			//delegate.getContactList();
			var ac:ArrayCollection = new ArrayCollection();
			var bob:Contact = new Contact();
			bob.firstName = 'Bob';
			bob.lastName = 'Dobbs';
			bob.id = 1;
			bob.email = 'bob@bob.com';
			bob.homePhone = "3031234567";
			ac.addItem(bob);
			model.contactList = ac;
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