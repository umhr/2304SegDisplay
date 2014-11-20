package anime 
{
	import com.adobe.utils.ArrayUtil;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author umhr
	 */
	public class Clock1
	{
		private var RAD_FROM_DEG:Number = Math.PI / 180;
		private var _bitmapData:BitmapData;
		public function Clock1() 
		{
			setNumberArray();
			setCode();
			setShapes();
			_bitmapData = new BitmapData(Main.samplingWidth, Main.samplingHeight, false, 0xFF000000);
		}
		
		private var _secondHand:Shape = new Shape();
		private var _minuteHand:Shape = new Shape();
		private var _hourHand:Shape = new Shape();
		private var _clockCanvas:Sprite = new Sprite();
		private var _rect:Rectangle = new Rectangle(0, 0, Main.samplingWidth, Main.samplingHeight);
		private var _count:int = 0;
		private var _prevTime:String = "";
		public function getVector(drawableObject:Sprite):Vector.<uint> {
			var time:String = "";
			time += new Date().hours + ":" + new Date().minutes + ";" + new Date().seconds + " ";
			if (_prevTime != time || (drawableObject && drawableObject.numChildren > 0)) {
				_bitmapData.fillRect(_rect, 0xFF000000);
				_prevTime = time;
				//setText("           12\n      11        1\n\n    10            2\n\n\n   9                3\n\n     8            4\n\n       7        5\n           6");
				setNumber();
				//setDish();
				enter();
				_bitmapData.draw(_clockCanvas);
				if (drawableObject && drawableObject.numChildren > 0) {
					_bitmapData.draw(drawableObject);
				}
			}
			return _bitmapData.getVector(_rect);
		}
		private function enter():void {
			var date:Date = new Date();
			_secondHand.rotation = date.seconds * 6;
			_minuteHand.rotation = date.minutes * 6;
			_hourHand.rotation = date.hours * 30 + date.minutes * 0.5;
		}
		private function setShapes():void {
			_secondHand.graphics.beginFill(0xFFFFFF);
			_secondHand.graphics.drawRect( 0, -35, 1, 40);
			_secondHand.graphics.endFill();
			_secondHand.x = 49;
			_secondHand.y = 37;
			_clockCanvas.addChild(_secondHand);
			_minuteHand.graphics.beginFill(0xFFFFFF);
			_minuteHand.graphics.drawRect( -1.2, -27, 2.4, 27);
			_minuteHand.graphics.endFill();
			_minuteHand.x = 49;
			_minuteHand.y = 37;
			_clockCanvas.addChild(_minuteHand);
			_hourHand.graphics.beginFill(0xFFFFFF);
			_hourHand.graphics.drawRect( -2.5, -20, 5, 20);
			_hourHand.graphics.endFill();
			_hourHand.x = 49;
			_hourHand.y = 37;
			_clockCanvas.addChild(_hourHand);
			
		}
		private function setDish():void {
			//_dish = new Shape();
			_dish.graphics.clear();
			_dish.graphics.beginFill(0xFFFFFF);
			for (var i:int = 0; i < 12; i++) 
			{
				//_bitmapData.setPixel(49 + 34 * Math.cos((30 * i) * RAD_FROM_DEG), 37 + 34 * Math.sin((30 * i) * i * RAD_FROM_DEG), 0xFFFFFF);
				//dish.graphics.drawRect(49 + 32 * Math.cos((30 * i) * RAD_FROM_DEG), 37 + 32 * Math.sin((30 * i) * i * RAD_FROM_DEG), 2, 2);
				//dish.graphics.drawRect(48+28*Math.cos(30*i * (Math.PI/180)),36+28*Math.sin(30*i * (Math.PI/180)),1,1);
				_dish.graphics.drawRect(49+32*Math.cos(30*i * (Math.PI/180)),37+32*Math.sin(30*i * (Math.PI/180)),1,1);
			}
			_dish.graphics.endFill();
			_clockCanvas.addChild(_dish);
		}
		private var _numberArray:Array/*String*/;
		private function setNumber():void {
			var list:Array = [];
			var timeList:Array/*Number*/ = [new Date().seconds/5, new Date().minutes/5, new Date().hours%12+new Date().minutes/60];
			for (var i:int = 0; i < 3; i++) 
			{
				var min:int = Math.floor(timeList[i]);
				var max:int = Math.ceil(timeList[i]);
				list[min] = min;
				list[max] = max;
			}

			for (i = 0; i < 13; i++) 
			{
				if (list[i] == null) {
					_bitmapData.setPixel(49+32*Math.cos(30*(i+9) * RAD_FROM_DEG),37+32*Math.sin(30*(i+9) * RAD_FROM_DEG),0xFFFFFF);
				}else {
					setText(_numberArray[list[i]]);
				}
			}
			_clockCanvas.addChild(_dish);
		}
		
		private function setNumberArray():void {
			_numberArray = [];
			_numberArray.push("           12");
			_numberArray.push("\n                1");
			_numberArray.push("\n\n\n                   2");
			_numberArray.push("\n\n\n\n\n\n                    3");
			_numberArray.push("\n\n\n\n\n\n\n\n                   4");
			_numberArray.push("\n\n\n\n\n\n\n\n\n\n                5");
			_numberArray.push("\n\n\n\n\n\n\n\n\n\n\n            6");
			_numberArray.push("\n\n\n\n\n\n\n\n\n\n        7");
			_numberArray.push("\n\n\n\n\n\n\n\n     8");
			_numberArray.push("\n\n\n\n\n\n    9");
			_numberArray.push("\n\n\n    10");
			_numberArray.push("\n       11");
			_numberArray.push("           12");
		}
		private var _charCode:Array/*Array*/ = [];
		private var _dish:Shape = new Shape();
		public function setText(str:String):void {
			str = str.toLocaleUpperCase();
			var dx:int = 0;
			var dy:int = 0;
			var n:int = str.length;
			for (var i:int = 0; i < n; i++) 
			{
				if (str.charCodeAt(i) == 10) {
					dx = 0;
					dy ++;
					continue;
				}
				
				var list:Array = _charCode[str.charCodeAt(i)];
				if (list) {
					list = ArrayUtil.copyArray(list);
					if (48 <= str.charCodeAt(i) && str.charCodeAt(i) < 58) {
						// ":".charCodeAt(0);// 58;
						// ";".charCodeAt(0);// 59;
						if (str.charCodeAt(i + 1) == 58 || str.charCodeAt(i + 1) == 59) {
							list.push(7);
						}
					}
					var m:int = list.length;
					for (var j:int = 0; j < m; j++) 
					{
						setSeg(list[j], dx,dy);
					}
					dx ++;
				if (dx % 24 == 0) {
					dx = 0;
					dy ++;
				}
				}
			}
			
		}
		public function setSeg(num:int,dx:int,dy:int):void {
			var tx:int = 2;
			var ty:int = 0;
			switch (num) 
			{
				case 0:tx = 2; ty = 0; break;
				case 1:tx = 3; ty = 2; break;
				case 2:tx = 2; ty = 3; break;
				case 3:tx = 3; ty = 4; break;
				case 4:tx = 2; ty = 5; break;
				case 5:tx = 0; ty = 4; break;
				case 6:tx = 0; ty = 1; break;
				case 7:tx = 3; ty = 5; break;
				default:
			}
			_bitmapData.setPixel(tx+dx*4, ty+dy*6, 0xFFFFFF);
		}
		
		private function setCode():void {
			_charCode[10] = [];//\n
			_charCode[32] = [];
			_charCode[46] = [7];//.
			_charCode[48+0] = [0, 1, 3, 4, 5, 6];//0
			_charCode[48+1] = [1, 3];
			_charCode[48+2] = [0, 1, 2, 4, 5];
			_charCode[48+3] = [0, 1, 2, 3, 4];
			_charCode[48+4] = [1,2,3,6];
			_charCode[48+5] = [0,6,2,3,4];
			_charCode[48+6] = [0,6,2,3,4,5];
			_charCode[48+7] = [0,1,3];
			_charCode[48+8] = [0,1,2,3,4,5,6];
			_charCode[48 + 9] = [0, 1, 2, 3, 4, 6]; //9
			
			_charCode[65 + 0] = [0, 1, 2, 3, 5, 6];//A
			_charCode[65 + 1] = [2, 3,4, 5, 6];
			_charCode[65 + 2] = [2, 4, 5];
			_charCode[65 + 3] = [1,2,3, 4, 5];
			_charCode[65 + 4] = [0,2,4,5,6];
			_charCode[65 + 5] = [0,2,5,6];
			_charCode[65 + 6] = [0,3,4,5,6];
			_charCode[65 + 7] = [2, 3, 5, 6];
			_charCode[65 + 8] = [3];
			_charCode[65 + 9] = [1,3,4,5];
			_charCode[65 + 10] = [0,2,3,5,6];//k
			_charCode[65 + 11] = [4,5,6];
			_charCode[65 + 12] = [0,1,3,5,6];
			_charCode[65 + 13] = [2,3,5];
			_charCode[65 + 14] = [2,3,4,5];
			_charCode[65 + 15] = [0,1,2,5,6];
			_charCode[65 + 16] = [0,1,2,3,6];
			_charCode[65 + 17] = [2,5];
			_charCode[65 + 18] = [2,3,4,6];
			_charCode[65 + 19] = [2,4,5,6];
			_charCode[65 + 20] = [3,4,5];//u
			_charCode[65 + 21] = [1,3,4,5,6];
			_charCode[65 + 22] = [1,2,3,4,5,6];
			_charCode[65 + 23] = [1,2,3,5,6];
			_charCode[65 + 24] = [1,2,3,4,6];
			_charCode[65 + 25] = [0,1,4,5];
			_charCode[95] = [4];//_
			
		}
	}

}