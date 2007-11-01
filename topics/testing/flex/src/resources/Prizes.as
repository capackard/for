package resources
{
	import org.onrails.rails.ActiveResourceClient;

	public class Prizes extends ActiveResourceClient
	{
		public function Prizes()
		{
			defineResource("prizes");
		}
		
	}
}