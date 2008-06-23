package com.flexonrails.outliner.events {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.flexonrails.outliner.vo.OutlinePoint;

	public class MovePointEvent extends CairngormEvent {
		
		public static const MovePoint_Event:String = "<MovePointEvent>";
		
		public var point:OutlinePoint;
		public var parentPoint:OutlinePoint;
		
		public function MovePointEvent(point:OutlinePoint, parentPoint:OutlinePoint) {
			super(MovePoint_Event);
			this.point = point;
			this.parentPoint = parentPoint;
		}
	}
}