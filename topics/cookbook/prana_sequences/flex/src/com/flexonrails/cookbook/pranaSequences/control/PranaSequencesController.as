package com.flexonrails.cookbook.pranaSequences.control {
	
	import com.adobe.cairngorm.control.FrontController;
    import com.flexonrails.cookbook.pranaSequences.commands.*;
    import com.flexonrails.cookbook.pranaSequences.events.*;
    
    /**
     *
     * Defines the <code>PranaSequencesController</code> which is 
     * utilized by the application to map each <code>Event</code>
     * object to an associated <code>ICommand</command> object.
     * 
     * @see com.adobe.cairngorm.control.FrontController
     *
     */
	public final class PranaSequencesController extends FrontController {
	    /**
	     *
	     * The <code>PranaSequencesController</code> constructor invokes
	     * the <code>initialize()</code> method so as to abstract the 
	     * <code>Event</code> / <code>Command</code> mappings from the
	     * constructor.
	     *
	     */
		public function PranaSequencesController() {
			this.initialize();
		}
		
	    /**
	     *
	     * The <code>initialize()</code> method maps each defined 
	     * <code>Event</code> to it's associated <code>ICommand</code>
	     * implementation.
	     *
	     */
		private function initialize():void {
			//todo: add commands
		}
	}
}
