package  
{
	
	import anime.Clock0;
	import anime.Clock1;
	import anime.Clock2;
	import anime.Text0;
	import anime.Text1;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import jp.mztm.umhr.logging.Log;
	/**
	 * ...
	 * @author umhr
	 */
	public class Canvas extends Sprite 
	{
		private var _cam:CameraCapture;
		//private var _bitmap:Bitmap;
		private var _sevenSegCanvas:SevenSegCanvas;
		private var _mapPixels:Vector.<uint>;
		private var _anime:Animation;
		public function Canvas() 
		{
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
			
			SegManager.getInstance().setup();
			
			_mapPixels = new Sampler().getMapVector();
			
			_sevenSegCanvas = new SevenSegCanvas();
			addChild(_sevenSegCanvas);
			
			_cam = new CameraCapture();
			//_cam.addEventListener(Event.CONNECT, cam_activate);
			//_bitmap = new Bitmap(_cam.bitmapData);
			//_bitmap.y = stage.stageHeight - _bitmap.height;
			//addChild(_bitmap);
			
			_moviePlayer = new MoviePlayer();
			addChild(_moviePlayer);
			
			_anime = new Animation();
			_ui = new UI(_anime);
			addChild(_ui);
			
			//addChild(new Bitmap(SegManager.getInstance().sheetBitmapDataList[1]));
			_text0 = new Text0();
			_text1 = new Text1();
			_clock0 = new Clock0();
			_clock1 = new Clock1();
			_clock2 = new Clock2();
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private var _moviePlayer:MoviePlayer;
		private var _ui:UI;
		private var _text0:Text0;
		private var _text1:Text1;
		private var _clock0:Clock0;
		private var _clock1:Clock1;
		private var _clock2:Clock2;
		private var _prevRemapLength:int = -1;
		private function enterFrame(e:Event):void 
		{
			_ui.enterFrame();
			//Log.timeStart();
			var pixels:Vector.<uint>;
			if(_ui.mode == UI.MOVIE){
				_moviePlayer.resume();
				pixels = _moviePlayer.getVector(_anime);
				_cam.active = false;
			}else if(_ui.mode == UI.CLOCK0){
				_moviePlayer.pause();
				pixels = _clock0.getVector(_anime);
				_cam.active = false;
			}else if(_ui.mode == UI.CLOCK1){
				_moviePlayer.pause();
				pixels = _clock1.getVector(_anime);
				_cam.active = false;
			}else if(_ui.mode == UI.CLOCK2){
				_moviePlayer.pause();
				pixels = _clock2.getVector(_anime);
				_cam.active = false;
			}else if(_ui.mode == UI.TEXT0){
				_moviePlayer.pause();
				pixels = _text0.getVector(_anime);
				_cam.active = false;
			}else if(_ui.mode == UI.TEXT1){
				_moviePlayer.pause();
				pixels = _text1.getVector(_anime);
				_cam.active = false;
			}else if(_ui.mode == UI.CAMERA0 || _ui.mode == UI.CAMERA1){
				_moviePlayer.pause();
				_cam.active = true;
				pixels = _cam.getVector(_anime);
			}
			var n:int = pixels.length;
			var remapList:Array = [];
			for (var i:int = 0; i < n; i++) 
			{
				var pix:uint = pixels[i] & 0xFF;
				var m:int;
				if (_ui.mode != UI.CAMERA1) {
					if (pix > 0x99) {
						m = _mapPixels[i] & 0xFFFFFF;
						remapList[m] = m;
					}
				}else {
					if (pix < 0x66) {
						m = _mapPixels[i] & 0xFFFFFF;
						remapList[m] = m;
					}
				}
			}
			
			if (remapList.length > 0 || _prevRemapLength > 0) {
				n = remapList.length;
				for (i = 0; i < n; i++) {
					if (remapList[i] != null && remapList[i] > -1) {
						_sevenSegCanvas.setSegs(remapList[i]);
					}
				}
				//Log.timeStart();
				_sevenSegCanvas.segDraw();
				//if(Math.random()>0.95){
					//Log.traceTime();
				//}
			}
			_prevRemapLength = remapList.length;
		}
	}
}