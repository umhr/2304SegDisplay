package  
{
	
	import a24.tween.Ease24;
	import a24.tween.Tween24;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author umhr
	 */
	public class UI extends Sprite 
	{
		static public const CAMERA:String = "camera";
		static public const CAMERA0:String = "camera0";
		static public const CAMERA1:String = "camera1";
		static public const MOVIE:String = "movie";
		static public const TEXT0:String = "text0";
		static public const TEXT1:String = "text1";
		static public const CLOCK0:String = "clock0";
		static public const CLOCK1:String = "clock1";
		static public const CLOCK2:String = "clock2";
		private var _bg:Sprite;
		private var _cameraBtn:Sprite;
		private var _movieBtn:Sprite;
		private var _clockBtn:Sprite;
		private var _textBtn:Sprite;
		private var _count:int = -900;
		private var _animation:Animation;
		private var _mode:String = MOVIE;
		private var _textInput:TextInputManager = TextInputManager.getInstance();
		public function UI(animation:Animation) 
		{
			_animation = animation;
			init();
		}
		private function init():void 
		{
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}

		private function onInit(event:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			// entry point
			graphics.beginFill(0x000000, 0);
			graphics.drawRect(0, 0, Main.stageWidth, Main.stageHeight);
			graphics.endFill();
			
			_bg = new Sprite();
			_bg.graphics.beginFill(0x000000, 0.5);
			_bg.graphics.drawRect(0, 0, Main.stageWidth, 75);
			_bg.graphics.endFill();
			//_bg.y = -_bg.height;
			addChild(_bg);
			
			_textInput.y =  -200;
			addChild(_textInput);
			
			_movieBtn = setButton(Main.stageWidth - 150, 4, "Demo", movieBtn_mouseDown);
			_bg.addChild(_movieBtn);
			_clockBtn = setButton(Main.stageWidth - 300, 4, "Clock", clockBtn_mouseDown);
			_bg.addChild(_clockBtn);
			_textBtn = setButton(Main.stageWidth - 450, 4, "Text", textBtn_mouseDown);
			_bg.addChild(_textBtn);
			
			mode = MOVIE;
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			_textInput.addEventListener(Event.CHANGE, textInput_change);
		}
		private function textInput_change(e:Event):void 
		{
			_count = -600;
		}
		private function setButton(x:int,y:int,text:String,listener:Function):Sprite {
			var result:Sprite = new Sprite();
			result.graphics.beginFill(0x333333, 1);
			result.graphics.drawRoundRect(0, 0, 142, 75 - 8, 0, 0);
			result.graphics.beginFill(0x222222, 1);
			result.graphics.drawRoundRect(2, 2, 138, 75 - 12, 0, 0);
			result.graphics.endFill();
			result.addEventListener(MouseEvent.MOUSE_DOWN, listener);
			result.x = x;
			result.y = y;
			//result.filters = [new DropShadowFilter(0,0,0x000000,0.5,16,16)];
			
			var textField:TextField = new TextField();
			textField.defaultTextFormat = new TextFormat("_sans", 32, 0x62B52F);
			textField.selectable = false;
			textField.mouseEnabled = false;
			textField.width = 135;
			textField.text = text;
			textField.x = 13;
			textField.y = 12;
			result.addChild(textField);
			
			return result;
		}
		
		private function textBtn_mouseDown(e:MouseEvent):void 
		{
			if (mode == TEXT0) {
				mode = TEXT1;
			}else {
				mode = TEXT0;
			}
		}
		
		private function clockBtn_mouseDown(e:MouseEvent):void 
		{
			if(mode == CLOCK0){
				mode = CLOCK1;
			}else if(mode == CLOCK1){
				mode = CLOCK2;
			}else {
				mode = CLOCK0;
			}
		}
		private function movieBtn_mouseDown(e:MouseEvent):void 
		{
			mode = MOVIE;
		}
		private function cameraBtn_mouseDown(e:MouseEvent):void 
		{
			if (mode == CAMERA0) {
				mode = CAMERA1;
			}else {
				mode = CAMERA0;
			}
		}
		
		private function mouseDown(e:MouseEvent):void 
		{
			//if (Main.isCamalive) {
				if (mouseY < 75) {
					_count = -200;
					Tween24.tween(_bg, 0.2, Ease24._2_QuadOut).y(0).play();
					if(_mode == TEXT0 || _mode == TEXT1){
						Tween24.tween(_textInput, 0.2, Ease24._2_QuadOut).y(0).play();
					}
				}
			//}
			
			var objectList:Array = stage.getObjectsUnderPoint(new Point(mouseX, mouseY));
			if (objectList.length > 0 && objectList[0].parent == "[object SevenSeg]") {
				var sevenSeg:SevenSeg = objectList[0].parent as SevenSeg;
				sevenSeg.changeColor();
			}
			_animation.mouseDown(mouseX, mouseY);
		}
		public function enterFrame():void {
			_count ++;
			if (_count == 0) {
				Tween24.tween(_bg, 1, Ease24._1_SineOut).y( -_bg.height-2).play();
				Tween24.tween(_textInput, 1, Ease24._1_SineOut).y( -_textInput.height-2).play();
			}
			if (Main.isCamalive && !_cameraBtn) {
				_cameraBtn = setButton(Main.stageWidth - 600, 4, "Camera", cameraBtn_mouseDown);
				_bg.addChild(_cameraBtn);
			}
		}
		public function get mode():String {
			return _mode;
		}
		public function set mode(value:String):void 
		{
			//_textInput.visible = false;
			//_textBtn.filters = [];
			_movieBtn.filters = [];
			if(_cameraBtn){
				_cameraBtn.filters = [];
			}
			_mode = value;
			if (_mode == MOVIE) {
				_movieBtn.filters = [new ColorMatrixFilter([0.5, 0, 0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0, 1, 0])];
			}else if (_mode == CLOCK0 || _mode == CLOCK0 || _mode == CLOCK0) {
			}else if (_mode == CAMERA0 || _mode == CAMERA1) {
				//_cameraBtn.filters = [new ColorMatrixFilter([0.5, 0, 0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0, 1, 0])];
			}else if (_mode == TEXT0) {
				//_textInput.visible = true;
				//_textBtn.filters = [new ColorMatrixFilter([0.5, 0, 0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0, 1, 0])];
			}
			
			if(_mode == TEXT0 || _mode == TEXT1){
				Tween24.tween(_textInput, 0.3, Ease24._1_SineOut).y(0).play();
			}else {
				Tween24.tween(_textInput, 0.3, Ease24._1_SineOut).y( -_textInput.height - 2).play();
			}
			
		}
	}	
}