package flexonrails.examples.stuff {

	import flexonrails.examples.stuff.controller.*;
	
	import org.puremvc.patterns.facade.Facade;
	
	public class ApplicationFacade extends Facade  {
		
		// Notification name constants
		public static const STARTUP:String 			= "startup";
		
		public static const LOAD_CONTEXTS:String	= "loadContexts";
		public static const CONTEXTS_LOADED:String	= "contextsLoaded";
		public static const SAVE_CONTEXT:String 	= "saveContext";
		public static const DELETE_CONTEXT:String 	= "deleteContext";
		public static const CONTEXT_SELECTED:String	= "contextSelected";
		public static const CONTEXT_ADDED:String	= "contextAdded";
		public static const CONTEXT_UPDATED:String	= "contextUpdated";
		public static const CONTEXT_DELETED:String	= "contextDeleted";

		public function ApplicationFacade(access:PrivateAccess) {
			super();
			if (!access) {
				throw new Error("ApplicationFacade must accessed from getInstance");
			}
		}
		
		public static function getInstance():ApplicationFacade {
			if (instance == null) {
				instance = new ApplicationFacade(new PrivateAccess());
			}
			return instance as ApplicationFacade;
		}

		/**
		 * Called by framwork to register commands with the controller 
		 */
		override protected function initializeController( ) : void 
		{
			super.initializeController();			
			registerCommand(STARTUP,		StartupCommand);
			registerCommand(LOAD_CONTEXTS,	LoadAllContextsCommand);
			registerCommand(DELETE_CONTEXT,	DeleteContextCommand);
			registerCommand(SAVE_CONTEXT,	SaveContextCommand);
		}
		
	}
}

/**
 * Inner class which restricts contructor access to Private
 */
class PrivateAccess {}

