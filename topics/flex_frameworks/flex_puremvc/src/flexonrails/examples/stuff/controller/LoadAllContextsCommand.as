package flexonrails.examples.stuff.controller {
	
	import flexonrails.examples.stuff.business.ContextsDelegate;
	import flexonrails.examples.stuff.model.ContextProxy;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.command.SimpleCommand;

	public class LoadAllContextsCommand extends SimpleCommand implements IResponder {
		
		private var contextProxy:ContextProxy;
		
		override public function execute(notification:INotification):void {
			contextProxy = facade.retrieveProxy(ContextProxy.NAME) as ContextProxy;
			var delegate:ContextsDelegate = new ContextsDelegate(this);
			delegate.loadAll();
		}
		
		public function result(data:Object):void {
			var result:ResultEvent = data as ResultEvent;
			contextProxy.reload(result.result as Array);
		}
		
		public function fault(info:Object):void {
			var fault:FaultEvent = info as FaultEvent;
		}
	}
}