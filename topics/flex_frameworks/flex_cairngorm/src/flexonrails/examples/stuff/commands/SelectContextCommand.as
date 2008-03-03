package flexonrails.examples.stuff.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flexonrails.examples.stuff.events.SelectContextEvent;
	import flexonrails.examples.stuff.model.StuffModelLocator;
	import flexonrails.examples.stuff.vo.Context;

	public class SelectContextCommand implements ICommand {
		
		private var model:StuffModelLocator = StuffModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void {
			var evt:SelectContextEvent = event as SelectContextEvent;
			var context:Context = evt.context;
			model.selectedContext = context;
		}
		
	}
}