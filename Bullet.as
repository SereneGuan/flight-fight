package plane
{

	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.media.*;
	import flash.system.Security;
	import flash.system.SecurityPanel;
	import flash.display.*;
	

	public class Bullet extends MovieClip
	{
		
		private var stageRef:Stage;
		private var bulletSpeed:Number = 16;
		//mic   
		private var mic:Microphone;
		private var mcnum:Number;
		
		public function Bullet (stageRef:Stage, x:Number, y:Number) : void
		{
			this.stageRef = stageRef;
			this.x = x;
			this.y = y;
			
			initMicphone();
			
 			addEventListener(Event.ENTER_FRAME, doShoot);
			
		}
		public function initMicphone():void
		{
			mic = Microphone.getMicrophone();
			mic.setLoopBack(true);
			mic.gain = 60;
			mcnum = 0;

		}
		public function doShoot(e:Event) : void
		{
			//move bullet up
			y -= bulletSpeed;
			mcnum = mic.activityLevel;
			
			
			if (y < 0) 
				removeSelf();
			
			
			
			//listen the sound level;
			if (mcnum>60)
			{				
				gotoAndPlay(2);
			}
			
			for (var i:int = 0; i < Plane.enemyList.length; i++)
			{
				if (hitTestObject(Plane.enemyList[i].hit)) 
				{
					trace("hitEnemy");
					Plane.enemyList[i].takeHit();
					removeSelf();
				}
			}
		}
		
		private function removeSelf() : void
		{
			removeEventListener(Event.ENTER_FRAME, doShoot);
			
			if (stageRef.contains(this))
					stageRef.removeChild(this);
		}
		
	}
	
}