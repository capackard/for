package com.flexonrails.outliner.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.flexonrails.outliner.business.OutlinePointsDelegate;
	import com.flexonrails.outliner.events.AddPointEvent;
	import com.flexonrails.outliner.model.ModelLocator;
	import com.flexonrails.outliner.vo.OutlinePoint;
	
	import mx.controls.Alert;
	import mx.controls.Tree;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class AddPointCommand implements ICommand, IResponder {
		
		private var model:ModelLocator = ModelLocator.getInstance();
		private var point:OutlinePoint;
		private var parentPoint:OutlinePoint;
		private var treeControl:Tree;
		
		public function execute(event:CairngormEvent):void {
			var evt:AddPointEvent = event as AddPointEvent;
			var delegate:OutlinePointsDelegate = new OutlinePointsDelegate(this);
			point = new OutlinePoint();
			parentPoint = evt.parentPoint;
			treeControl = evt.tree;
			delegate.save(point, parentPoint);
		}
		
		public function result(data:Object):void {
			var result:ResultEvent = data as ResultEvent;
			var returnedPoint:OutlinePoint = result.result as OutlinePoint;
			point.id = returnedPoint.id;
			parentPoint.children.addItem(point);
			treeControl.invalidateList();
		}
		
		public function fault(info:Object):void {
			var fault:FaultEvent = info as FaultEvent;
			Alert.show(fault.fault.message, "Error Saving Outline Point");
		}
		
	}
}