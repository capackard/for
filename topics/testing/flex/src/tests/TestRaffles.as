package tests
{
	import flexunit.framework.*;	
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	import resources.Raffles;
	
	public class TestRaffles extends BaseTestCase
	{	
		private var raffles:Raffles;
		
	    public function TestRaffles(name : String = null)
	    {
	        super(name);
	        fixtures(["raffles"]);
			raffles = new Raffles();
	    }		
	
	    public function testRemoteFindRaffle():void
	    {
			assertRemote(raffles.show(1));
	    }
	    public function assertRemote_testRemoteFindRaffle(data:Object):void
	    {
	    	Assert.assertTrue("Raffle find successfully called", data is ResultEvent);  
	    	assertEquals("MyString", data.result.name);
	    }		
	
	}
}
