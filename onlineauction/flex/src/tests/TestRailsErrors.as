package tests

import flexunit.framework.*;
import mx.controls.Alert;
import org.onrails.myspyder.utils.ItemResponder;

public class TestRailsErrors extends TestCase
{
	import flash.events.Event;
	import org.onrails.rails.RailsErrors;
	

    public function TestRailsErrors(name : String = null)
    {
        super(name);
    }
    
    public function testGetErrorFields():void
    {
		var railsError:RailsErrors = new RailsErrors(  	
		<errors>
		  <error>Password confirmation can not be blank</error>
		  <error>Password can not be blank</error>
		  <error>Password is too short (minimum is 4 characters)</error>
		  <error>Email can not be blank</error>
		  <error>Email is too short (minimum is 3 characters)</error>
		</errors>
		);
		Assert.assertEquals(5, railsError.errors.length());
		Assert.assertEquals(2, railsError.fields.length);
		Assert.assertEquals('Password', railsError.fields[0]);
		Assert.assertEquals('Email', railsError.fields[1]);
		Assert.assertEquals( 'can not be blank', railsError.getFieldErrors('Email')[0]);
		Assert.assertEquals( 'is too short (minimum is 3 characters)', railsError.getFieldErrors('Email')[1]);
    }
		
} // class

} //package