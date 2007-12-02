package flexonrails.examples.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flexonrails.examples.business.ContactListDelegate;
	import flexonrails.examples.events.RemoveContactEvent;
	import flexonrails.examples.model.ContactListModel;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;

	public class RemoveContactCommand implements ICommand, IResponder {
		
		private var model:ContactListModel = ContactListModel.getInstance();
		
		public function execute(event:CairngormEvent):void {
			var evt:RemoveContactEvent = event as RemoveContactEvent;
			var delegate:ContactListDelegate = new ContactListDelegate(this);
			delegate.remove(evt.contact);
		}
		
		public function result(data:Object):void {
			var re:ResultEvent = data as ResultEvent;
		}
		
		public function fault(info:Object):void {
			Alert.show("Unable to remove contact.");
		}
		
	}
}