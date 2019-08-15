package plane
{
	import flash.events.*;
	import flash.utils.Timer;
	import flash.media.*;
	import flash.system.Security;
	import flash.system.SecurityPanel;
	import flash.display.*;
	

	public class Ship extends MovieClip
	{

		private var stageRef:Stage;
		private var speed:Number = 0.5;
		private var vx:Number = 0;
		private var vy:Number = 0;
		private var friction:Number = 0.53;
		private var maxspeed:Number = 8;
		private var ourShip:Ship;
		private var bullet:Bullet;
		//mic   
		private var mic:Microphone;
		private var mcnum:Number;
				
		//fire related variables
		private var fireTimer:Timer; //causes delay between fires
		private var canFire:Boolean = true; //can you fire a laser
		

		public function Ship(stageRef:Stage) : void
		{
			this.stageRef = stageRef;
			//setup your fireTimer and attach a listener to it.
			fireTimer = new Timer(100, 5);
			fireTimer.addEventListener(TimerEvent.TIMER, fireTimerHandler);
			
			initMicphone();

			
			addEventListener(Event.ENTER_FRAME, loop);
			
			
		}
		//set  Microphone   
		public function initMicphone():void
		{
			mic = Microphone.getMicrophone();
			mic.setLoopBack(true);
			mic.gain = 60;
			mcnum = 0;

			//addEventListener(Event.ENTER_FRAME, loop);
			addEventListener(Event.ENTER_FRAME, doShoot);

		}
		public function loop(e:Event) : void
		{				
			
			
			x += vx;
			y += vy;
			
			//speed adjustment
			if (vx > maxspeed)
				vx = maxspeed;
			else if (vx < -maxspeed)
				vx = -maxspeed;
				
			if (vy > maxspeed)
				vy = maxspeed;
			else if (vy < -maxspeed)
				vy = -maxspeed;
			
			//ship appearance
			rotation = vx;
			scaleX = (maxspeed - Math.abs(vx))/(maxspeed*4) + 0.75;
			
			//stay inside screen
			if (x > stageRef.stageWidth) 
			{
				x = stageRef.stageWidth;
				vx = -vx;
			}
			else if (x < 0) 
			{
				x = 0;
				vx = -vx;
			}
			
			if (y > stageRef.stageHeight)
			{
				y = stageRef.stageHeight;
				vy = -vy+2;
			}
			else if (y < 0) 
			{
				y = 0;
				vy = -vy;
			}
			
			

		}
		public function doShoot(e:Event) : void
		{				
			fireBullet();
		}
		
		
		public function fireBullet() : void
		{
			//if canFire is true, fire a bullet
			//set canFire to false and BgStart our timer
			//else do nothing.
			mcnum = mic.activityLevel;
			
			if (canFire && mcnum> 20)
			{
				stageRef.addChild(new Bullet(stageRef, x + vx, y - 10));
				canFire = false;
				fireTimer.start();
			}
			
			//trace(mcnum);
		}
		
		
		//HANDLERS
		
		private function fireTimerHandler(e:TimerEvent) : void
		{
			//timer ran, we can fire again.
			canFire = true;
		}
		
		public function takeHit() : void
		{
			dispatchEvent(new Event("hit"));
		}

	}

}