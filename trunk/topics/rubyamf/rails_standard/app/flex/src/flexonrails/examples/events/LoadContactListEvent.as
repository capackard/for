package flexonrails.examples.events {
	
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadContactListEvent extends CairngormEvent {
		public static const LOAD_CONTACT_LIST:String = "LOAD_CONTACT_LIST"
	
		public function LoadContactListEvent() {
			super(LOAD_CONTACT_LIST);
		}
			
	}
}