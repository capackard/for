package flexonrails.examples.stuff.model {
	
	import flexonrails.examples.stuff.ApplicationFacade;
	import flexonrails.examples.stuff.model.vo.Context;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class ContextProxy extends Proxy {
		
		public static const NAME:String = 'ContextProxy';
		
		public function ContextProxy() {
			super(NAME, new ArrayCollection());
		}

		// return data property cast to proper type
		public function get contexts():ArrayCollection {
			return data as ArrayCollection;
		}

		public function reload(newContexts:Array):void {
			contexts.disableAutoUpdate();
			contexts.removeAll();
			for each (var context:Context in newContexts) {
				contexts.addItem(context);
			}
			contexts.enableAutoUpdate();
			sendNotification(ApplicationFacade.CONTEXTS_LOADED);
		}
		
		public function addItem(item:Object):void {
			contexts.addItem(item);
		}
				
		public function updateItem(item:Object):void {
			var context:Context = item as Context;
			for (var i:int=0; i<contexts.length; i++) {
				if (contexts[i].id == context.id) {
					contexts[i] = context;
					break;
				}
			}
		}
		
		public function deleteItem(item:Object):void {
			var context:Context = item as Context;
			for (var i:int=0; i<contexts.length; i++) {
				if ( contexts[i].id == context.id) {
					contexts.removeItemAt(i);
					break;
				}
			}
		}
		
	}
}