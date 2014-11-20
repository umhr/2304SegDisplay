package anime 
{
	
	import a24.tween.Ease24;
	import a24.tween.Tween24;
	import flash.display.Shape;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author umhr
	 */
	public class Cube extends Sprite 
	{
		private var _cubeA:Sprite = new Sprite();
		private var _cubeB:Sprite = new Sprite();
		public function Cube(x:int,y:int) 
		{
			this.x = x;
			this.y = y;
			init();
		}
		private function init():void 
		{
			var shapeA:Shape = new Shape();
			shapeA.graphics.beginFill(0xFF0000);
			shapeA.graphics.drawRect( -50, -50, 100, 100);
			shapeA.graphics.endFill();
			shapeA.z = 50;
			_cubeA.addChild(shapeA);
			
			var shapeB:Shape = new Shape();
			shapeB.graphics.beginFill(0xFF0000);
			shapeB.graphics.drawRect( -50, -50, 100, 100);
			shapeB.graphics.endFill();
			shapeB.z = -50;
			_cubeA.addChild(shapeB);
			
			addChild(_cubeA);
			
			var shapeC:Shape = new Shape();
			shapeC.graphics.beginFill(0xFF0000);
			shapeC.graphics.drawRect( -50, -50, 100, 100);
			shapeC.graphics.endFill();
			shapeC.z = 50;
			_cubeB.addChild(shapeC);
			
			var shapeD:Shape = new Shape();
			shapeD.graphics.beginFill(0xFF0000);
			shapeD.graphics.drawRect( -50, -50, 100, 100);
			shapeD.graphics.endFill();
			shapeD.z = -50;
			_cubeB.addChild(shapeD);
			
			addChild(_cubeB);
			
			Tween24.loop(0,
			Tween24.parallel(
				Tween24.serial(
					Tween24.prop(_cubeA).z( -450).rotationY(90) ,
					Tween24.tween(_cubeA, 2, Ease24._1_SineOut).z(600),
					Tween24.prop(_cubeA).z( -450),
					Tween24.tween(_cubeA, 2, Ease24._1_SineOut).z(600),
					Tween24.prop(_cubeA).z( -450),
					Tween24.tween(_cubeA, 2, Ease24._1_SineOut).z(600),
					Tween24.prop(_cubeA).z( -450),
					Tween24.tween(_cubeA, 2, Ease24._1_SineOut).z(600),
					Tween24.prop(_cubeA).visible(false)
				),
				Tween24.serial(
					Tween24.prop(_cubeB).z( -450).rotationY(90).rotationZ(90) ,
					Tween24.wait(1),
					Tween24.tween(_cubeB, 2, Ease24._1_SineOut).z(600),
					Tween24.prop(_cubeB).z( -450),
					Tween24.tween(_cubeB, 2, Ease24._1_SineOut).z(600),
					Tween24.prop(_cubeB).z( -450),
					Tween24.tween(_cubeB, 2, Ease24._1_SineOut).z(600),
					Tween24.prop(_cubeB).z( -450),
					Tween24.tween(_cubeB, 2, Ease24._1_SineOut).z(600),
					Tween24.prop(_cubeB).visible(false)
				),
				Tween24.prop(_cubeA).visible(true),
				Tween24.prop(_cubeB).visible(true)
			)).play();
		}
		
	}
	
}