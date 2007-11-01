package tests
{
	import flexunit.framework.*;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	
	import org.onrails.rails.FixtureResource;
	import org.onrails.rails.utils.ItemResponder;
	
	public class BaseTestCase extends TestCase
	{
		private var fixtureResource:FixtureResource;
		private var fixtureNames:XML;
		private var fixturesLoaded:Object = {};
		
	    public function BaseTestCase(name : String = null)
	    {
	        super(name);
			fixtureResource = new FixtureResource(getFixtureCreatedCallBack);
	    }		
		
		public function fixtures(names:Array):void {
			//["users", "pages"] --> <fixtures><fixture>users</fixture><fixture>pages</fixture></fixtures>
			fixtureNames = <fixtures/>
			for each (var fixture:String in names) {
				fixtureNames.fixture += <fixture>{fixture}</fixture>;
			}
		}
		
		/**
		 * Facility method to create fixtures.
		 * @param names The names of all the fixtures to create (Array of string)
		 * @param creationCompleteCallback The method to invoke upon creation of the fixtures (or failure)
		 * @return 
		 * 
		 */
		public function createFixtures(creationCompleteCallback:Function):AsyncToken
		{
			
		   	return fixtureResource.createFixtures(fixtureNames, creationCompleteCallback);
		}
		
		public function getFixtureCreatedCallBack():Function
		{
			return addAsync(fixtureCreated, 1000);	
		}
		
	    public function fixtureCreated(data:Object):void 
		{
			Assert.assertTrue("Fixuture creation", data is ResultEvent);
			data.token.creationCompleteCallback();
		}
		
		public function assertRemote(call:AsyncToken, timeout:Number=1000):void {
	 	    var asyncCall:Function = addAsync(this["assertRemote_"+methodName], timeout);
			call.addResponder(new ItemResponder(asyncCall, asyncCall));			
		}		
		
	    override public function runMiddle():void
	    {
	    	var match:Array = methodName.match(/^testRemote/);
			if (match && !fixturesLoaded[methodName]) {
				fixturesLoaded[methodName] = true;
				createFixtures(this[methodName]);				
			} else {
	        	super.runMiddle()				
			}	    	
	    }
		
	}
}