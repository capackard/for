package tests
{
	import flexunit.framework.TestCase;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.events.FaultEvent;
	
	public class TestNotesResource extends TestCase
	{
		private var notesResource:NotesResource = new NotesResource();
		override public function setUp():void {
		}		
		public function testList():void{
	 	    var asyncCall:Function = addAsync(assertTestList, 1000);					
			var call:AsyncToken = notesResource.notes.send();
			call.addResponder(new ItemResponder(asyncCall, asyncCall));
		}
		public function assertTestList(result:Object, token:Object = null):void {
			assertTrue(result is ResultEvent);
			assertEquals(2, result.result.note.length());
			assertEquals("MyString", result.result.note[0].title);
			trace(result.result.toXMLString());
		}
	}
}