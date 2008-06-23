package com.flexonrails.outliner.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.flexonrails.outliner.business.OutlinePointsDelegate;
	import com.flexonrails.outliner.events.RemovePointEvent;
	import com.flexonrails.outliner.model.ModelLocator;
	import com.flexonrails.outliner.vo.OutlinePoint;
	
	import mx.controls.Alert;
	import mx.controls.Tree;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class RemovePointCommand implements ICommand, IResponder {
		
		private var model:ModelLocator = ModelLocator.getInstance();
		private var point:OutlinePoint;
		private var parentPoint:OutlinePoint;
		private var treeControl:Tree;
		
		public function execute(event:CairngormEvent):void {
			var evt:RemovePointEvent = event as RemovePointEvent;
			var delegate:OutlinePointsDelegate = new OutlinePointsDelegate(this);
			point = evt.point;
			parentPoint = point.parent;
			treeControl = evt.tree;
			
			delegate.destroy(point);
		}
		
		public function result(data:Object):void {
			var result:ResultEvent = data as ResultEvent;
			var index:int = parentPoint.children.getItemIndex(point);
			parentPoint.children.removeItemAt(index);
			treeControl.invalidateList();
		}
		
		public function fault(info:Object):void {
			var fault:FaultEvent = info as FaultEvent;
			Alert.show(fault.fault.message, "Error Saving Outline Point");
		}
		
	}
}