package tests
{
	import flexunit.framework.*;
	import flexunit.framework.TestCase;
	import org.onrails.rails.FixtureResource;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	
	public class BaseTestCase extends TestCase
	{
		private var fixtures:FixtureResource;
		
	    public function BaseTestCase(name : String = null)
	    {
	        super(name);
			fixtures = new FixtureResource(getFixtureCreatedCallBack);
	    }		
		
		
		/**
		 * Facility method to create fixtures.
		 * @param names The names of all the fixtures to create (Array of string)
		 * @param creationCompleteCallback The method to invoke upon creation of the fixtures (or failure)
		 * @return 
		 * 
		 */
		public function createFixtures(names:Array, creationCompleteCallback:Function):AsyncToken
		{
			//["users", "pages"] --> <fixtures><fixture>users</fixture><fixture>pages</fixture></fixtures>
			var data:XML = <fixtures/>
			for each (var fixture:String in names) {
				data.fixture += <fixture>{fixture}</fixture>;
			}
		   	return fixtures.createFixtures(data, creationCompleteCallback);
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
		
	}
}