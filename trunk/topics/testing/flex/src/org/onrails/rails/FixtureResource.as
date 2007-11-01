package org.onrails.rails
{
	import mx.rpc.AsyncToken;
	import org.onrails.rails.ActiveResourceClient;
	import org.onrails.rails.utils.ItemResponder;
	public class FixtureResource extends ActiveResourceClient
	{
		private var fixtureCreatedCallBack:Function ; // Assume TestCase Class
		
		public function FixtureResource(fixtureCreatedCallBack:Function)
		{
			defineResource("fixtures", true);
			this.fixtureCreatedCallBack = fixtureCreatedCallBack;
		}
		
		public function createFixtures(data:Object, creationCompleteCallback:Function):AsyncToken {			
			var call:AsyncToken = super.create(data);
			var asyncCall:Function = fixtureCreatedCallBack();
			call.addResponder(new ItemResponder(asyncCall, asyncCall));
			call.creationCompleteCallback = creationCompleteCallback;
			return call;
		}
		
		public function testResults(testResults:String):AsyncToken {
			createOperation.url = path+"/new/test_results";
			return createOperation.send(<results><data>{testResults}</data></results>);
		}
	}
}