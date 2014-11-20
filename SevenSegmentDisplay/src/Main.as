package 
{
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import net.hires.debug.Stats;
	
	/**
	 * ...
	 * @author umhr
	 */
	//[SWF(width = 800, height = 600, backgroundColor = 0x000000, frameRate = 30)]
	public class Main extends Sprite 
	{
		static public var stageWidth:int;
		static public var stageHeight:int;
		static public var samplingWidth:int;
		static public var samplingHeight:int;
		/**
		 * 7セグを横に並べる個数
		 */
		static public var sevenSegWidth:int = 24;
		/**
		 * 7セグを縦に並べる個数
		 */
		static public var sevenSegHeight:int = 12;
		static public var os:String;
		static public const OS_iOS:String = "ios";
		static public const OS_Android:String = "android";
		static public const OS_PC:String = "pc";
		static public var isCameraInvert:Boolean = false;
		static public var isCamalive:Boolean;
		static public var segCanvasRectangle:Rectangle = new Rectangle();
		static public var activeSeg:Rectangle = new Rectangle();
		public function Main():void 
		{
			//stage.setOrientation(StageOrientation.ROTATED_RIGHT);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			// iOSでテキストフィールドへのフォーカスに対してソフトウェアキーボードが表示されなくなる。
			// http://qiita.com/tsunet111/items/49b79c9cb083963e8d1d
			// stage.displayState = "fullScreen";
			
			if (Capabilities.manufacturer.indexOf("iOS") != -1) {
				os = OS_iOS;
			}else if (Capabilities.manufacturer.indexOf("Android") != -1) {
				os = OS_Android;
			} else {
				os = OS_PC;
			}
			Main.stageWidth = Main.os == Main.OS_PC?stage.stageWidth:stage.fullScreenWidth;
			Main.stageHeight = Main.os == Main.OS_PC?stage.stageHeight:stage.fullScreenHeight;
			// touch or gesture?
			//Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// entry point
			addChild(new Canvas());
			//addChild(new Stats());
			
			//var text:TextField = new TextField();
			//text.text = os + Capabilities.manufacturer;
			//text.width = 400;
			//addChild(text);
		}
		
		private function deactivate(e:Event):void 
		{
			// auto-close
			NativeApplication.nativeApplication.exit();
		}
		
	}
	
}