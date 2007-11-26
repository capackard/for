package flexonrails.examples.vo {
	
	[RemoteClass(alias="Contact")]
	[Bindable]
	public class Contact {
		
		public var id:int;
		public var firstName:String;
		public var lastName:String;
		public var email:String;
		public var homePhone:String;
		public var workPhone:String;
		
		// transient
		public var newContact:Boolean = true;
		
	}
}