package anime 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	 * ...
	 * @author umhr
	 */
	public class Clock 
	{
		private var _bitmapData:BitmapData;
		private var _isNarrow:Boolean;
		public function Clock() 
		{
			if (Main.stageHeight / Main.stageWidth < 2 / 3) {
				_isNarrow = true;
			}
			
			_bitmapData = new BitmapData(Main.samplingWidth, Main.samplingHeight, false, 0xFF000000);
			_textField = new TextField();
			if (_isNarrow) {
				_textField.defaultTextFormat = new TextFormat("_sans", 72, 0xFFFFFF,null,null,null,null,null,TextFormatAlign.RIGHT,null,null,null,-26);
			}else {
				_textField.defaultTextFormat = new TextFormat("_sans", 72, 0xFFFFFF,null,null,null,null,null,TextFormatAlign.RIGHT,null,null,null,-16);
			}
			_textField.width = Main.samplingWidth*2;
			_textField.height = Main.samplingHeight*3;
			_textField.multiline = _textField.wordWrap = true;
			
		}
		
		private var _rect:Rectangle = new Rectangle(0, 0, Main.samplingWidth, Main.samplingHeight);
		private var _count:int = 0;
		private var _text:String = "";
		public function getVector(drawableObject:Sprite):Vector.<uint> {
			_bitmapData.fillRect(_rect, 0xFF000000);
			_text = new Date().toTimeString().split(" ")[0];
			var isDrawObject:Boolean = drawableObject && drawableObject.numChildren > 0;
			if (_textField.text != _text || isDrawObject) {
				_textField.text = _text;
				if (_isNarrow) {
					_bitmapData.draw(_textField, new Matrix(0.5, 0, 0, 0.5, 0, 3.5), null, null, null, true);
				}else {
					_bitmapData.draw(_textField, new Matrix(0.5, 0, 0, 0.5, 0, -2), null, null, null, true);
				}
				if (isDrawObject) {
					_bitmapData.draw(drawableObject);
				}
			}
			return _bitmapData.getVector(_rect);
		}
		private var _textField:TextField;
	}

}