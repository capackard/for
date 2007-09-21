package resources
{
	import org.onrails.rails.ActiveResourceClient;

	public class Bids extends ActiveResourceClient
	{
		public function Bids()
		{
			defineResource("bids");
		}
		
	}
}