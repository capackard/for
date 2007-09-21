package tests 
{

import flexunit.framework.*;
import mx.rpc.IResponder;
import mx.controls.Alert;
import org.onrails.rails.utils.ItemResponder;
import resources.Users;
import mx.utils.ArrayUtil;
import mx.rpc.AsyncToken;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import flash.events.Event;

public class TestUsers extends BaseTestCase
{
	
	
	private var userResource:Users;
	
	override public function setUp():void {
		userResource = new Users();
	}

    public function TestUsers(name : String = null)
    {
        super(name);
    }
	
	
	/* FIND USER */
	
    public function testFindUser():void
    {
    	createFixtures(["users"], doTestFindUser);
    }

	public function doTestFindUser():void {
 	    var asyncCall:Function = addAsync(findUserResult, 1000);
		var call:AsyncToken = userResource.show(1);
		call.addResponder(new ItemResponder(asyncCall, asyncCall));
	}

    public function findUserResult(data:Object):void
    {
    	Assert.assertTrue("Find User call", data is ResultEvent);
    	var user:Object = (data as  ResultEvent).result;   
    	Assert.assertEquals("Daniel", user.name);
    }


		
} // class

} //package