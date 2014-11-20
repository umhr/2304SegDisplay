package anime 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author umhr
	 */
	public class Text 
	{
		private var _bitmapData:BitmapData;
		public function Text() 
		{
			setCode();
			_bitmapData = new BitmapData(Main.samplingWidth, Main.samplingHeight, false, 0xFF000000);
		}
		
		private var _rect:Rectangle = new Rectangle(0, 0, Main.samplingWidth, Main.samplingHeight);
		private var _count:int = 0;
		public function getVector(drawableObject:Sprite):Vector.<uint> {
			_bitmapData.fillRect(_rect, 0xFF000000);
			setText("\n\n\n\n     2304 seg display\n\n     by mztm.jp");
			//_bitmapData.setPixel(Math.random() * Main.samplingWidth, Math.random() * Main.samplingHeight, 0xFFFFFF);
			//_bitmapData.perlinNoise(Main.samplingWidth, Main.samplingHeight, 4, Math.random()*100, false, true, 6, true);
			if (drawableObject && drawableObject.numChildren > 0) {
				_bitmapData.draw(drawableObject);
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
			//trace("_".charCodeAt(0));
			//var list:Array/*Array*/ = [];
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
			_charCode[48 + 9] = [0, 1, 2, 3, 4, 6];
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