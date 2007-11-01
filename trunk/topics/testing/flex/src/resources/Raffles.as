package resources
{
	import org.onrails.rails.ActiveResourceClient;

	public class Raffles extends ActiveResourceClient
	{
		public function Raffles()
		{
			defineResource("raffles");
		}
		
	}
}