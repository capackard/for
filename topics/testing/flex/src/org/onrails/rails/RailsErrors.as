package org.onrails.rails
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class RailsErrors extends EventDispatcher 
	{
		private var _errors:XML;
		private var _errorlist:XMLList; // (errors.error or errors.info)
		private var _fieldList:Array;
		private var _fieldMap:Object;
		private var _info:Boolean; // false - errors, true - info message
		
		public function RailsErrors(errors:XML) {
			setErrors(errors);
		}
		
		public function clear():void {
			_errors = null;
			_fieldList = null;
			_fieldMap = null;			
		}
		
		private function setErrors(value:XML):void {
 			_errorlist = value.error;
 			_info = false;
 			if (_errorlist.length() ==0) {
 				_errorlist = value.info; //FIXME: Transform RailsErrors to RailsResult that support errors and information message.
 				if (_errorlist.length()>0) _info = true;
 			}			
			_errors = _errorlist.length() >0 ? value : null;
			_errors ? parseErrors() : clear();
			//dispatchEvent(new Event("changeErrors"));
		}
		
		[Bindable(event="changeErrors")] 
		public function get errors():XMLList {
			return _errorlist; //FIXME: should clone?
		}
		
		[Bindable(event="changeErrors")] 
		public function get fields(): Array {
			return _fieldList;
		}
		
		[Bindable(event="changeErrors")] 
		public function get info(): Boolean {
			return _info;
		}
		
		[Bindable(event="changeErrors")] 
		public function get text():String {
			var message:String = "";
			for each (var error:XML in _errorlist) {
				message += "\n"+error.toString();
			}
			return message;
		}
		
		public function getFieldErrors(fieldName:String):Array {
			return _fieldMap[fieldName];
		}
		
		public function getFieldError(fieldName:String):String {
			if (_fieldMap[fieldName] && _fieldMap[fieldName].length()>0)
				return _fieldMap[fieldName][0];
			else 
				return null;
		}

		[Bindable(event="changeErrors")] 
		public function hasErrors():Boolean {
			return _errorlist.length() >0;
		}

		[Bindable(event="changeErrors")] 
		public function get length():Number {
			return _errors ? _errorlist.length() : 0;
		}				
		
		private function parseErrors():void {
			var fieldList:Array = [];
			var fieldMap:Object = {};
 			var wordsRegEx:RegExp = /\s+/;
			for each (var error:XML in _errorlist) {
				var fullMessage:String = error.toString();
				var words:Array = fullMessage.split(wordsRegEx);
				var field:String = words.shift();
				var message:String = words.join(' ');
				if (fieldMap[field] == undefined) {
					fieldList.push(field)
					fieldMap[field] = [];
				}
				fieldMap[field].push(message);				
			}
			this._fieldList = fieldList;
			this._fieldMap = fieldMap;
		}
	}
}