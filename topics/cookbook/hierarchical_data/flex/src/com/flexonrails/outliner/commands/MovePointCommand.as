package com.flexonrails.outliner.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.flexonrails.outliner.events.MovePointEvent;
	import com.flexonrails.outliner.model.ModelLocator;

	public class MovePointCommand implements ICommand {
		
		private var model:ModelLocator = ModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void {
			var evt:MovePointEvent = event as MovePointEvent;
		}
		
	}
}