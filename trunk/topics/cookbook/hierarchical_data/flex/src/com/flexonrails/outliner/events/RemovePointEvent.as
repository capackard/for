package com.flexonrails.outliner.events {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.flexonrails.outliner.vo.OutlinePoint;
	
	import mx.controls.Tree;

	public class RemovePointEvent extends CairngormEvent {
		public static const RemovePoint_Event:String = "<RemovePointEvent>";
		
		public var point:OutlinePoint;
		public var tree:Tree;

		
		public function RemovePointEvent(point:OutlinePoint, tree:Tree) {
			super(RemovePoint_Event);
			this.point = point;
			this.tree = tree;
		}
	}
}