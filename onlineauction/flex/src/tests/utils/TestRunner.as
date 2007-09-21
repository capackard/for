package tests.utils
{

import flash.utils.*;
import flexunit.framework.*;
import flexunit.runner.*;

public class TestRunner extends BaseTestRunner
{
	[Bindable]
	public var log:String="";
	
    public function TestRunner(onComplete:Function=null)
    {
        printer = new TextResultPrinter();
        testsComplete = onComplete;
    }
    
    

//------------------------------------------------------------------------------

    public static function run( test:Test, onComplete:Function=null ):TestResult
    {
        return new TestRunner(onComplete).doRun( test );
    }
    
//------------------------------------------------------------------------------

    private function doRun( test:Test ):TestResult
    {
        result = new TestResult();
        result.addListener(TestListener( printer ));
        result.addListener(TestListener( this ));

        startTime = getTimer();
        totalTestCount = test.countTestCases();
        numTestsRun = 0;
        test.runWithResult( result );
        return result;
    }

//------------------------------------------------------------------------------

    override public function testEnded( test : Test ):void
    {
        if (++numTestsRun == totalTestCount)
        {
            var endTime:Number = getTimer();

            var runTime:Number = endTime - startTime;

            printer.print( result, runTime );
            if(testsComplete != null)
            {
                log += printer.log;
                testsComplete(printer.log);
            }
        }
    }

    private var printer : TextResultPrinter;
    private var startTime : int;
    private var totalTestCount : int;
    private var numTestsRun : int;
    private var result:TestResult;
    private var testsComplete:Function;
}

}
