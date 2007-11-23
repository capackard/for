package tests
{
	import flexunit.framework.TestCase;
	import mx.rpc.AsyncResponder;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	
	public class TestNotesResource extends TestCase
	{
		private var notesResource:NotesResource = new NotesResource();
		override public function setUp():void {
		}						
/*		
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
						
		public function testCreate():void{
	 	    var asyncCall:Function = addAsync(assertTestCreate, 1000);
	 	    var newNote:XML =  <note>
							    <title>My First Note</title>
							    <body>Is this a hello world? Not even funny.</body>
							  </note>					
			var call:AsyncToken = notesResource.noteCreate.send(newNote);
			call.addResponder(new ItemResponder(asyncCall, asyncCall));
		}
		public function assertTestCreate(result:Object, token:Object = null):void {
			assertTrue(result is ResultEvent);
			assertEquals("My First Note", result.result.title);
		}
		
		public function testUpdate():void{
	 	    var note:XML =  <note>
							    <body>Testing Updates</body>
							  </note>					
	 	    notesResource.id = 1;
			var call:AsyncToken = notesResource.noteUpdate.send(note);
			var token:Object = {noteId:notesResource.id, nextCallBack:addAsync(assertTestUpdateData, 1000)};
			call.addResponder(new AsyncResponder(assertTestUpdateSuccess, assertTestUpdateSuccess, token));
		}
		public function assertTestUpdateSuccess(result:Object, token:Object = null):void {
			assertTrue(result is ResultEvent);
			notesResource.id = token.noteId;
			var call:AsyncToken = notesResource.noteShow.send();
			call.addResponder(new ItemResponder(token.nextCallBack, token.nextCallBack));
		}
		public function assertTestUpdateData(result:Object, token:Object = null):void {
			assertTrue(result is ResultEvent);
			assertEquals("Testing Updates", result.result.body);
		}
*/				
		public function testDelete():void{
	 	    var asyncCall:Function = addAsync(assertTestDelete, 1000);
	 	    notesResource.id = 1;							  				
			var call:AsyncToken = notesResource.noteDelete.send();
			call.addResponder(new ItemResponder(asyncCall, asyncCall));
		}
		public function assertTestDelete(result:Object, token:Object = null):void {
			assertTrue(result is ResultEvent);
			assertEquals("My First Note", result.result.title);
		}
/*				
		public function testValidation():void{
	 	    var asyncCall:Function = addAsync(assertTestValidation, 1000);
	 	    var newNote:XML =  <note>
							  </note>					
			var call:AsyncToken = notesResource.noteCreate.send(newNote);
			call.addResponder(new ItemResponder(asyncCall, asyncCall));
		}
		public function assertTestValidation(result:Object, token:Object = null):void {
			assertTrue(result is ResultEvent);
			assertEquals("errors", result.result.name());
			var errors:XML = result.result
			assertEquals(2, errors.error.length());
			assertEquals("Body can't be blank", errors.error[0]);			
			assertEquals("Title can't be blank", errors.error[1]);						
		}		
*/		
	}
}