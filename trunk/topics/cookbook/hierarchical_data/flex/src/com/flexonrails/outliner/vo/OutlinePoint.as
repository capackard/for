package com.flexonrails.outliner.vo {
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	[RemoteClass(alias="OutlinePoint")]
	public class OutlinePoint {
		
		public var id:Number;
		public var label:String = "New Outline Point";
		public var parent:OutlinePoint;
		public var createdAt:Date;
		public var updatedAt:Date;
		
		public var children:ArrayCollection;
		
		public var errors:Array;

	}
}