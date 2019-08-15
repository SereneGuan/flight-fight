package plane
{
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.media.*;
	import flash.system.Security;
	import flash.system.SecurityPanel;
	import flash.display.*;
	
	
	public class Enemies extends MovieClip
	{
		
		private var stageRef:Stage;
		
		private var vy:Number = 4;
		private var vx:Number;
		private var ay:Number = .2;
		private var target:Ship;
		private var planeDir:Number;
		private var startX:Number;
		//mic   
		private var mic:Microphone;
		private var mcnum:Number;
		
		//score points
		public var points:int = 200;
		
		public function Enemies(stageRef:Stage, target:Ship) : void
		{
			
			
			
			stop();
			this.stageRef = stageRef;
			this.target = target;
			
			x = Math.random() * stageRef.stageWidth;
			y = -5;
			startX =x;
			
			
			if(x<stageRef.stageWidth/2)
			{
				vx = -2;
				
			}
			else
			{
				vx = 2;
				//x+=50;
			}
				//trace("方向是"+vx);
				

			initMicphone();
			
			addEventListener(Event.ENTER_FRAME, doStart);
			
			
		}
		private function initMicphone():void
		{
			mic = Microphone.getMicrophone();
			mic.setLoopBack(true);
			mic.gain = 60;
			mcnum = 0;

		}
		
		private function doStart(e:Event) : void 
		{
								
			if (currentLabel != "destroyed")
			{
				vy += ay;
				y += vy;
				
				if (y > stageRef.stageHeight){
					removeSelf();
				}
					
				if (y - 15 < target.y && y + 15 > target.y){
					fireWeapon();
				}
			}	
				
			if (currentLabel == "destroyedComplete"){
				removeSelf();
			}
			
			
			
			
			
			
			mcnum = mic.activityLevel;
			
			
			
			//listen the sound level;
			if (mcnum>70)
			{				
				planeDir = 1;
				x+= vx*planeDir*20;
			}
			else if (mcnum<50)
			{
				planeDir = -1;
				x+= vx*planeDir;
				
			}
			
			
		}
		
		
		private function fireWeapon() : void
		{
			stageRef.addChild(new EnemiesBullet(stageRef, target, x, y, -8));
			stageRef.addChild(new EnemiesBullet(stageRef, target, x, y, 8));
		}
		
		private function removeSelf() : void {
			
			removeEventListener(Event.ENTER_FRAME, doStart);
			
			if (stageRef.contains(this))
				stageRef.removeChild(this);
			
		}
		
		public function takeHit() : void
		{
			if (currentLabel != "destroyed") //insure we can't keep killing the enemy ship... over and over
			{
				dispatchEvent(new Event("killed")); //our new ship killed event
				rotation = Math.random() * 360;
				gotoAndPlay("destroyed");
			}
		}
		
	}
	
}