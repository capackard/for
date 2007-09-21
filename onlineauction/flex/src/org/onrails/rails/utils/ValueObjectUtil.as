package org.onrails.rails.utils
{
	import mx.utils.ObjectUtil;
	
	public class ValueObjectUtil
	{
		public static function updateAttributes (valueObject : Object, object : Object) : void
		{
			var attributes : Array = ObjectUtil.getClassInfo ( object ).properties;
			
			for each (var attribute : String in attributes)
			{
				if ( valueObject.hasOwnProperty (attribute) )
					valueObject[attribute] = object[attribute]
			}			
		}
		
	}
}