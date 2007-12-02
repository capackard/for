package flexonrails.examples.vo {
	
	[Bindable]
	[RemoteClass(alias="Contact")]
	public class Contact {
		
		public var id:int;
		public var firstName:String;
		public var lastName:String;
		public var email:String;
		public var homePhone:String;
		public var officePhone:String;
		
	}
}