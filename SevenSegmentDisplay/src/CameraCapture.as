/*
 * Cameraクラス
 * http://help.adobe.com/ja_JP/AS3LCR/Flex_4.0/flash/media/Camera.html
 *
 * Videoクラス
 * http://help.adobe.com/ja_JP/AS3LCR/Flex_4.0/flash/media/Video.html
 * */
package {
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.StatusEvent;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.media.Video;
	public class CameraCapture {
		private var _bitmapData:BitmapData = new BitmapData(Main.samplingWidth, Main.samplingHeight, false);
		private var _video:Video;
		private var _matrix:Matrix;
		private var _colorTransform:ColorTransform = new ColorTransform(1, 1, 1, 0.3);
		public function CameraCapture() {
			setCamera();
		}
		public function setCamera():void {
			var camera:Camera = Camera.getCamera((Camera.names.length - 1).toString());
			//カメラの存在を確認
			if (camera) {
				var ratio:Number = Main.samplingWidth / 320;
				_matrix = new Matrix( -ratio, 0, 0, ratio, Main.samplingWidth);
				if(Main.os == Main.OS_iOS){
					_matrix = new Matrix( ratio, 0, 0, ratio);
				}
				camera.addEventListener(StatusEvent.STATUS, camera_status);
				camera.setMode(320, 240, 30);
				_video = new Video();
				_video.attachCamera(camera);
				_colorMatrix = new Array();
				_colorMatrix = _colorMatrix.concat([0.30, 0.59, 0.11, 0, 0]); // red
				_colorMatrix = _colorMatrix.concat([0.30, 0.59, 0.11, 0, 0]); // green
				_colorMatrix = _colorMatrix.concat([0.30, 0.59, 0.11, 0, 0]); // blue
				_colorMatrix = _colorMatrix.concat([0, 0, 0, 1, 0]); // alpha
				_video.filters = [new ColorMatrixFilter(_colorMatrix)];
				Main.isCamalive = true;
				//this.addChild(_video);
				//trace("カメラ?");
				if (Main.os != Main.OS_PC) {
					Main.isCamalive = true;
				}
			} else {
				trace("カメラが見つかりませんでした。");
			}
		}
		
		private function camera_status(e:StatusEvent):void 
		{
			if (e.code == "Camera.Unmuted") {
				Main.isCamalive = true;
			}
		}
		private var _active:Boolean;
		private var _colorMatrix:Array;
		public function set active(value:Boolean):void {
			if (_active == value) { return };
			_active = value;
			
			if(_video){
				if (value) {
					if (Main.os == Main.OS_PC) {
						_video.filters = [new ColorMatrixFilter(_colorMatrix), new BlurFilter()];
					}else {
						_video.filters = [new ColorMatrixFilter(_colorMatrix)];
					}
				}else {
					_video.filters = [];
				}
			}
		}
		
		public function get bitmapData():BitmapData {
			return _bitmapData;
		}
		private var _rect:Rectangle = new Rectangle(0, 0, Main.samplingWidth, Main.samplingHeight);
		//private var _blendMode:String = null;
		public function getVector(drawableObject:Sprite):Vector.<uint> {
			if (_video) {
				//_blendMode = Main.isCameraInvert?BlendMode.INVERT:BlendMode.NORMAL;
				if (Main.os == Main.OS_PC) {
					_bitmapData.draw(_video, _matrix, _colorTransform);
				}else {
					_bitmapData.draw(_video, _matrix);
				}
			}
			if (drawableObject && drawableObject.numChildren > 0) {
				_bitmapData.draw(drawableObject);
			}
			return _bitmapData.getVector(_rect);
		}
	}
}