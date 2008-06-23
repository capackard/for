package com.flexonrails.outliner.events {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.flexonrails.outliner.vo.OutlinePoint;
	
	import mx.controls.Tree;

	public class AddPointEvent extends CairngormEvent {
		public static const AddPoint_Event:String = "<AddPointEvent>";
		
		public var parentPoint:OutlinePoint;
		public var tree:Tree;
		
		public function AddPointEvent(parentPoint:OutlinePoint, tree:Tree) {
			super(AddPoint_Event);
			this.parentPoint = parentPoint;
			this.tree = tree;
		}
	}
}