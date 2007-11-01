package resources
{
	import org.onrails.rails.ActiveResourceClient;

	public class Participants extends ActiveResourceClient
	{
		public function Participants()
		{
			defineResource("participants");
		}
		
	}
}