package org.onrails.rails
{
	
	import flash.events.Event;
	import flash.events.FocusEvent;
	import mx.core.UIComponent;
	import mx.controls.Button;	
	import com.wheelerstreet.utils.ValidatorForm;
	
	public class RailsValidationForm extends com.wheelerstreet.utils.ValidatorForm
	{
		
		private var _railsErrors:RailsErrors;
		private var _fieldMap:Object;
		
		public function RailsValidationForm()
		{
			super();
		}

		public function set fieldMap(fields:Object):void {
			_fieldMap = fields;
		}
		
			
		public function set railsErrors(errors:RailsErrors):void {
			_railsErrors = errors;
			if (_railsErrors==null || !_railsErrors.hasErrors()) {
				resetErrors();
				//Button(defaultButton).enabled = true;  			
			} else {
				//Button(defaultButton).enabled = false;
	            for each (var field:String in _railsErrors.fields) {
	            	if (_fieldMap[field]) 
	            		_fieldMap[field].errorString = field + ' ' + _railsErrors.getFieldErrors(field).join(', ');
	            }				
			}
		}
		
		/**
		 * Clear error message of all validators. 
		 **/
		public function resetErrors(): void {
			for each(var v:Object in _validatorList) 
			{
				var inputField:UIComponent = v.source;
                inputField.errorString = "";
				v.suppressEvents = true;
				inputField.removeEventListener(Event.CHANGE,handleDataChange);
				inputField.addEventListener(FocusEvent.FOCUS_IN, addToEventsList);				
			}
		}

	
	} // class
} // package