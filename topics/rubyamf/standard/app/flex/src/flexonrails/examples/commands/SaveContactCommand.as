package flexonrails.examples.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flexonrails.examples.business.ContactListDelegate;
	import flexonrails.examples.events.SaveContactEvent;
	import flexonrails.examples.model.ContactListModel;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;

	public class SaveContactCommand implements ICommand, IResponder {
		
		private var model:ContactListModel = ContactListModel.getInstance();
		
		public function execute(event:CairngormEvent):void {
			var evt:SaveContactEvent = event as SaveContactEvent;
			var delegate:ContactListDelegate = new ContactListDelegate(this);
			delegate.save(evt.contact);
		}
		
		public function result(data:Object):void {
			var re:ResultEvent = data as ResultEvent;
		}
		
		public function fault(info:Object):void {
			Alert.show("Unable to save contact");
		}
		
	}
}