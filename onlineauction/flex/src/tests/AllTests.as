package tests
{

import flexunit.framework.TestSuite;

public class AllTests
{
	public static function suite() : TestSuite
	{
		var testSuite:TestSuite = new TestSuite();		
		testSuite.addTestSuite( TestUsers );
//		testSuite.addTestSuite( TestRailsErrors );
		return testSuite;
	}
}

}