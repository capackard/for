package flexonrails.examples.business {
	
	import flexonrails.examples.events.RemoveContactEvent;
	import flexonrails.examples.events.SaveContactEvent;
	import flexonrails.examples.model.ContactListModel;
	import flexonrails.examples.vo.Contact;
	
	import mx.binding.utils.ChangeWatcher;
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.PropertyChangeEvent;
	
	public class ContactListObserver {
		
		private var model:ContactListModel = ContactListModel.getInstance();
		
		public function ContactListObserver() {
			ChangeWatcher.watch(model, 'contactList', contactListSet);
		}
		
		private function contactListSet(pce:PropertyChangeEvent):void {
			if (pce.oldValue) {
				var oldAC:ArrayCollection = pce.oldValue as ArrayCollection
				oldAC.removeEventListener(CollectionEvent.COLLECTION_CHANGE, contactListChanged);
			}
			if (model.contactList) {
				model.contactList.addEventListener(CollectionEvent.COLLECTION_CHANGE, contactListChanged);
			}
		}
		
		private function contactListChanged(ce:CollectionEvent):void {
			var changeEvent:PropertyChangeEvent;
			var changedItem:Contact;
			
			switch (ce.kind) {
				
				case CollectionEventKind.ADD :
					for each (changedItem in ce.items) {
						new SaveContactEvent(changedItem).dispatch();
					}
				break;
				
				case CollectionEventKind.REMOVE :
					for each (changedItem in ce.items) {
						new RemoveContactEvent(changedItem).dispatch();
					}
				break;
				
				case CollectionEventKind.UPDATE :
					for each (changeEvent in ce.items) {
						changedItem = changeEvent.source as Contact;
						new SaveContactEvent(changedItem).dispatch();
					}
				break;
				
			}
		}
		
	}
}