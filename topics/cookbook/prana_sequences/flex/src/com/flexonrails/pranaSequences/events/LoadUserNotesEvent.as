package com.flexonrails.pranaSequences.events {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.flexonrails.pranaSequences.vo.User;

	public class LoadUserNotesEvent extends CairngormEvent {
		
		public static const LoadUserNotes_Event:String = "<LoadUserNotesEvent>";
		
		public var user:User;
		
		public function LoadUserNotesEvent(user:User) {
			super(LoadUserNotes_Event);
			this.user = user;
		}
	}
}