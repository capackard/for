package resources
{
	import org.onrails.rails.ActiveResourceClient;

	public class Items extends ActiveResourceClient
	{
		public function Items()
		{
			defineResource("items");
		}
		
	}
}