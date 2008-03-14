package flexonrails.examples.stuff.view {
	
	import flexonrails.examples.stuff.ApplicationFacade;
	import flexonrails.examples.stuff.model.vo.Context;
	import flexonrails.examples.stuff.view.components.MainView;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class MainViewMediator extends Mediator {
		
		public static const NAME:String = 'MainViewMediator';

		public function MainViewMediator(viewComponent:Object) {
			super(NAME, viewComponent);
			
//			contextProxy = facade.retrieveProxy(ContextProxy.NAME) as ContextProxy;
		}
		
		private function get mainView():MainView {
			return viewComponent as MainView;
		}
		
		override public function listNotificationInterests():Array {
			return [ApplicationFacade.CONTEXT_SELECTED];
		}
		
		override public function handleNotification(note:INotification):void {
			switch (note.getName()) {
				case ApplicationFacade.CONTEXT_SELECTED:
					var context:Context = note.getBody() as Context;
					mainView.selectedContext = context;
				break;
					
			}
		}
		
	}
}