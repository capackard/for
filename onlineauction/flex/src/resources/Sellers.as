package resources
{
	import org.onrails.rails.ActiveResourceClient;

	public class Sellers extends ActiveResourceClient
	{
		public function Sellers()
		{
			defineResource("sellers");
		}
		
	}
}