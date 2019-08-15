package plane
{
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class EnemiesBullet extends MovieClip
	{
		
		private var stageRef:Stage;
		private var target:Ship;
		
		private var vx:Number;
		
		public function EnemiesBullet(stageRef:Stage, target:Ship, x:Number, y:Number, vx:Number) : void
		{
			this.stageRef = stageRef;
			this.target = target;
			this.x = x;
			this.y = y;
			this.vx = vx;
			
			addEventListener(Event.ENTER_FRAME, doAttack);
		}
		
		private function doAttack(e:Event) : void
		{
			x += vx;
			
			if (x > stageRef.stageWidth || x < 0)
				removeSelf();
				
			if (hitTestObject(target.hit))
			{
				target.takeHit(); 
				stageRef.addChild(new Explosion(stageRef, x, y));
				removeSelf();
			}
		}
		
		private function removeSelf() : void
		{
			removeEventListener(Event.ENTER_FRAME, doAttack);
			if (stageRef.contains(this))
				stageRef.removeChild(this);
		}
		
	}
	
}