package  
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author umhr
	 */
	public class TextInputManager extends Sprite 
	{
		private static var _instance:TextInputManager;
		public function TextInputManager(block:Block){init();};
		public static function getInstance():TextInputManager{
			if ( _instance == null ) {_instance = new TextInputManager(new Block());};
			return _instance;
		}
		
		private var _textField:TextField = new TextField();
		private function init():void
		{
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}

		private function onInit(event:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			// entry point
			
			var q:int = Main.stageWidth;
			var w:int = q * 0.275;
			var h:int = w * (Main.stageHeight/Main.stageWidth);
			var fontSize:int = q * 0.018;
			
			var rect:Rectangle = getTextWH(fontSize);
			var textFormat:TextFormat = new TextFormat("_typewriter", fontSize, 0xFFFFFF);
			textFormat.leading = -fontSize * 0.15;
			_textField.defaultTextFormat = textFormat;
			_textField.borderColor = 0x666666;
			_textField.border = true;
			_textField.background = true;
			_textField.mouseWheelEnabled = false;
			_textField.backgroundColor = 0x222222;
			_textField.width = rect.width + 12;// fontSize * 0.85;
			_textField.height = rect.height - 12;// fontSize * 1.8;
			//_textField.wordWrap = true;
			//_textField.multiline = true;
			_textField.maxChars = Main.activeSeg.width * Main.activeSeg.height + Main.activeSeg.height-1;
			
			var text:String = "\n\n\n\n    2304 seg display\n\n          by mztm.jp";
			_textField.text = text.substr(Main.activeSeg.y);
			_textField.type = TextFieldType.INPUT;
			addChild(_textField);
			_textField.addEventListener(Event.CHANGE, textField_change);
		}
		
		private function getTextWH(fontSize:int):Rectangle {
			var textFormat:TextFormat = new TextFormat("_typewriter", fontSize, 0xFFFFFF);
			textFormat.leading = -fontSize * 0.15;
			_textField.defaultTextFormat = textFormat;
			_textField.borderColor = 0x333333;
			_textField.border = true;
			_textField.background = true;
			_textField.backgroundColor = 0x222222;
			_textField.multiline = true;
			var text:String = "";
			for (var i:int = 0; i < Main.activeSeg.height; i++) 
			{
				for (var j:int = 0; j < Main.activeSeg.width; j++) 
				{
					text += "_";
				}
				text += "\n";
			}
			_textField.width = 400;
			_textField.height = 300;
			_textField.text = text;
			_textField.type = TextFieldType.INPUT;
			
			return new Rectangle(0, 0, _textField.textWidth, _textField.textHeight);
		}
		
		private function textField_change(e:Event):void 
		{
			//var text:String = _textField.text;
			//var returnCount:int = 0;
			//var n:int = text.length;
			//for (var i:int = 0; i < n; i++) 
			//{
				//returnCount ++;
				//if (returnCount == Main.activeSeg.width + 1) {
					//text = text.substr(0, i) + "\n" + text.substr(i);
					//i --;
				//}
				//if (text.charAt(i) == "\n" || text.charAt(i) == "\r") {
					//returnCount = 0;
				//}
			//}
			//_textField.text = text;
			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function getText():String {
			var text:String = "";
			for (var i:int = 0; i < Main.activeSeg.y; i++) 
			{
				text += "\n";
			}
			text += _textField.text;
			var returnCount:int = 0;
			var n:int = text.length;
			for (i = 0; i < n; i++) 
			{
				returnCount ++;
				//if (returnCount == Main.activeSeg.width + 1) {
					//returnCount = 0;
				//}
				
				if (text.charAt(i) == "\n" || text.charAt(i) == "\r") {
					if (returnCount == Main.activeSeg.width + 1) {
						text = text.substr(0, i) + text.substr(i + 1);
						i --;
					}
					returnCount = 0;
				}
			}
			
			return text;
		}
		
		
	}
	
}
class Block { };