package anime 
{
	import com.adobe.utils.ArrayUtil;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author umhr
	 */
	public class Clock2 
	{
		private var _bitmapData:BitmapData;
		public function Clock2() 
		{
			setCode();
			_bitmapData = new BitmapData(Main.samplingWidth, Main.samplingHeight, false, 0xFF000000);
		}
		
		private var _rect:Rectangle = new Rectangle(0, 0, Main.samplingWidth, Main.samplingHeight);
		private var _count:int = 0;
		private var _prevTime:String = "";
		public function getVector(drawableObject:Sprite):Vector.<uint> {
			var time:String = "";
			time += new Date().hours + ":" + new Date().minutes + ";" + new Date().seconds + " ";
			if (_prevTime != time || (drawableObject && drawableObject.numChildren > 0)) {
				_prevTime = time;
				_bitmapData.fillRect(_rect, 0xFF000000);
				var str:String = "";
				var n:int = Math.ceil((24 * 12) / (time.length - 2)) + 1;
				for (var i:int = 0; i < n; i++) 
				{
					str += time;
				}
				// 横に流れるようにする
				n = new Date().seconds % (time.length-2);
				for (i = 0; i < n; i++) 
				{
					if (time.substr(i, 1) == ":" || time.substr(i, 1) == ";") {
						n ++;
					}
				}
				str = str.substr(n);
				
				setText(str);
				
				if (drawableObject && drawableObject.numChildren > 0) {
					_bitmapData.draw(drawableObject);
				}
			}
			return _bitmapData.getVector(_rect);
		}
		private var _charCode:Array/*Array*/ = [];
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