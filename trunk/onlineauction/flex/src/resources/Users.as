package resources
{
	import org.onrails.rails.ActiveResourceClient;

	public class Users extends ActiveResourceClient
	{
		public function Users()
		{
			defineResource("users");
		}
		
	}
}