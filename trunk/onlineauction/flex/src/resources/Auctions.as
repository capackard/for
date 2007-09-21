package resources
{
	import org.onrails.rails.ActiveResourceClient;

	public class Auctions extends ActiveResourceClient
	{
		public function Auctions()
		{
			defineResource("auctions");
		}
		
	}
}