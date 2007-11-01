package tests.org.onrails.myspyder.utils
{
import flash.utils.*;
import flexunit.framework.*;
import flexunit.utils.*;

public class TextResultPrinter implements TestListener
{

	[Bindable]	
	public var log:String="";

    public function TextResultPrinter()
    {
        super();
        _progress = "";
    }

	private function message(msg:String): void {
	   log += "\n"+msg;	
	}
//------------------------------------------------------------------------------

    public function print( result:TestResult, runTime:Number ):void
    {
        if ( _progress.length > 0 )
            message( _progress );

        printHeader(runTime);
        printErrors(result);
        printFailures(result);
        printFooter(result);
    }

//------------------------------------------------------------------------------

    public function printHeader( runTime:Number ):void
    {
        message( "Time: " + ( runTime / 1000 ) + " seconds" );
    }

//------------------------------------------------------------------------------

    public function printErrors( result:TestResult ):void
    {
        printDefects( result.errorsIterator(), result.errorCount(), "error" );
    }

//------------------------------------------------------------------------------

    public function printFailures( result:TestResult ):void
    {
        printDefects( result.failuresIterator(), result.failureCount(), "failure" );
    }

//------------------------------------------------------------------------------

    public function printDefects( defects:Iterator, count:Number, type:String ):void
    {
        if ( count == 0 )
            return;

        if ( count == 1 )
            message( "There was " + count + " " + type + ":" );
        else
            message( "There were " + count + " " + type + "s:");

        for ( var i:Number = 1; defects.hasNext(); i++)
        {
            printDefect( TestFailure( defects.next() ), i );
        }
    }

//------------------------------------------------------------------------------

    private function printDefect( defect:TestFailure, count:Number ):void
    {
        printDefectHeader( defect, count );
        printDefectmessage( defect );
    }

//------------------------------------------------------------------------------

    private function printDefectHeader( defect:TestFailure, count:Number ):void
    {
        message( count + ") " + defect.failedTest().toString() );
    }

//------------------------------------------------------------------------------

    private function printDefectmessage( defect:TestFailure ):void
    {
        message( "\t" + defect.exceptionMessage() );
    }

//------------------------------------------------------------------------------

    private function printFooter( result:TestResult ):void
    {
        if ( result.wasSuccessful() )
        {
            message( "" );
            message( "OK (" + result.runCount() + " test" + ( result.runCount() == 1 ? "" : "s") + ")" );
        }
        else
        {
            message( "" );
            message( "FAILURES!!!" );
            message( "Tests run: " + result.runCount() +
                         ",  Failures: " + result.failureCount() +
                         ",  Errors: " + result.errorCount() );
        }
       message( "" );
    }

//------------------------------------------------------------------------------

    public function addError( test:Test, error:Error ):void
    {
        updateProgress( "E" );
    }

//------------------------------------------------------------------------------

    public function addFailure( test:Test, error:AssertionFailedError ):void
    {
        updateProgress( "F" );
    }

//------------------------------------------------------------------------------

    public function endTest( test:Test ):void
    {
    }

//------------------------------------------------------------------------------

    public function startTest( test:Test ):void
    {
        updateProgress( "." );
    }

//------------------------------------------------------------------------------

    private function updateProgress( lr:String ):void
    {
        _progress = _progress + lr;
        if ( _progress.length > 40 )
        {
            message( _progress );
            _progress = "";
        }
    }

//------------------------------------------------------------------------------

    private var _progress:String;
}

}
