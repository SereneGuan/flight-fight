package plane 
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.*;
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	import com.danzen.frameworks.Easy;
	
	
	
	public class Plane extends MovieClip
	{
		
		private var numBgStars:int = 1000;
		public static var enemyList:Array = new Array();
		private var ourShip:Ship;
		private var scoreHUD:ScoreHUD;
		private var intro:Intro;
		
		
		public function Plane() : void
		{
			intro = new Intro();
			addChild(intro);
			intro.doButton.addEventListener(MouseEvent.CLICK, init);
			
			
			
		}
		function init(e:MouseEvent)
		{

			intro.gotoAndPlay(1);
			TweenMax.to(intro.doButton, 1, {autoAlpha:0});
			
			
			startGame();
			
		}
		public function startGame(){
			
			
			ourShip = new Ship(stage);
			
			ourShip.addEventListener("hit", shipHit);
			stage.addChild(ourShip);
			
			
			scoreHUD = new ScoreHUD(stage);
			stage.addChild(scoreHUD);
			
			for (var i:int = 0; i < numBgStars; i++)
			{
				stage.addChildAt(new BgStar(stage), stage.getChildIndex(ourShip));
			}
			
			addEventListener(Event.ENTER_FRAME,followcursor);
			addEventListener(Event.ENTER_FRAME, doStart);
			

		}
		
		public function followcursor(e:Event): void{
			ourShip.x = mouseX;
			ourShip.y = mouseY;
		}
		
		public function doStart(e:Event) : void
		{
			//enemies number
			if (Math.floor(Math.random() * 30) == 10)
			{
				var enemy:Enemies = new Enemies(stage, ourShip);
				
				enemy.addEventListener(Event.REMOVED_FROM_STAGE, removeEnemy);
				enemy.addEventListener("killed", enemyKilled);
				enemyList.push(enemy);
				stage.addChild(enemy);
				
				
				
				
				
			}	
		}
		
		private function enemyKilled(e:Event)
		{
			
			scoreHUD.updateScore(e.currentTarget.points);			
		}
		
		private function removeEnemy(e:Event)
		{
			enemyList.splice(enemyList.indexOf(e.currentTarget), 1);
		}
		
		private function shipHit(e:Event)
		{
			scoreHUD.updateHits(1);
		}
		
		
		
	}
	
}