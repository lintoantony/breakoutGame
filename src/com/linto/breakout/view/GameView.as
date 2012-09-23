/*
@author : linto (lintoka123@gmail.com)
*/
package com.linto.breakout.view {
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import com.linto.breakout.controller.GameController;
	import com.linto.breakout.model.Model;
	
	public class GameView extends Sprite{
		
		public var ball:Ball;
		public var paddle:Paddle;
		public var stageRef:Stage;
		public var bricks:Bricks;
		public var gameState:GameState;
		private var gameOverScreen:GameOverScreen;
		private var levelCompletedScreen:LevelCompletedScreen;
		
		private var controllerRef:GameController;
		private var modelRef:Model;
		
		public function GameView(stageRef:Stage, controllerRef:GameController, modelRef:Model) {
			this.controllerRef = controllerRef;
			this.modelRef = modelRef;
			this.stageRef = stageRef;
			
			this.attachAssets();
		}
		
		private function attachAssets():void{
			this.attachBg();
			this.attachGameElements();
			this.attachStartScreen();
		}
		
		private function attachGameElements():void{
			this.attachBricks();
			this.attachPaddle();
			this.attachBall();
		}
		
		private function attachStartScreen():void{
			var startScreen:StartScreen = new StartScreen();
			startScreen.name = "startScreen";
			startScreen.x = 5;
			startScreen.y = 5;
			startScreen.startBut.addEventListener(MouseEvent.CLICK, onStartClick);
			this.addChild(startScreen);
		}
		
		private function onStartClick(evt:MouseEvent):void{
			var startScreen:StartScreen = this.getChildByName("startScreen") as StartScreen;
			startScreen.startBut.removeEventListener(MouseEvent.CLICK, onStartClick);
			this.removeChild(this.getChildByName("startScreen") as StartScreen);
			this.startGame();
		}
		
		public function startGame():void{
			this.ball.startBall();
			this.paddle.startPaddle();
			this.bricks.addBricks(this.modelRef.totalBricks);
			
			this.attachGameState();
		}
		
		public function restartGame():void{
			this.attachGameElements();
			this.startGame();
		}
		
		public function gotoNextLevel():void{
			this.attachGameElements();
			this.startGame();
		}

		private function attachBg():void{
			var bgMc:BgMc = new BgMc();
			bgMc.width = this.stageRef.stageWidth;
			bgMc.height = this.stageRef.stageHeight;
			this.addChild(bgMc);
		}
		
		private function attachBricks():void{
			this.bricks = new Bricks(this);
			this.bricks.x = 9;
			this.bricks.y = 5;
			this.addChild(this.bricks);
		}
		
		private function attachBall():void{
			this.ball = new Ball(this, this.stageRef);
			this.ball.x = this.stageRef.stageWidth/2 + 5;
			this.ball.y = 150;
			this.ball.addEventListener(Ball.DECREMENT_LIFE, onDecrementLife);
			this.addChild(this.ball);
		}
		
		private function attachGameState():void{
			this.gameState = new GameState();
			this.gameState.y = this.stageRef.stageHeight - this.gameState.height;
			this.addChild(this.gameState);
			this.gameState.lifesMc.gotoAndStop(this.modelRef.getLifeStatus());
			this.gameState.levelTxt.text = "Level "+ this.modelRef.level;
			this.gameState.scoreTxt.text = "Score "+ this.modelRef.score;
		}
		
		private function onDecrementLife(evt:Event):void{
			this.controllerRef.decrimentLife();
			this.gameState.lifesMc.gotoAndStop(this.modelRef.getLifeStatus());
		}
		
		private function attachPaddle():void{
			this.paddle = new Paddle(this, this.stageRef);
			this.paddle.x = this.stageRef.stageWidth/2;
			this.paddle.y = this.stageRef.stageHeight - 60;
			this.addChild(this.paddle);
		}
		
		private function clearAssets():void{
			this.bricks.clearBricks(this.modelRef.totalBricks);
			this.removeChild(this.bricks);
			
			this.ball.removeEventListener(Ball.DECREMENT_LIFE, onDecrementLife);
			this.removeChild(this.ball);
			
			this.removeChild(this.gameState);
			this.removeChild(this.paddle);
		}
		
		private function attachGameOverScreen():void{
			this.gameOverScreen = new GameOverScreen();
			this.gameOverScreen.x = 5;
			this.gameOverScreen.y = 5;
			this.gameOverScreen.tryAgainBut.addEventListener(MouseEvent.CLICK, onTryAgain);
			this.addChild(this.gameOverScreen);
		}
		
		private function onTryAgain(evt:MouseEvent):void{
			this.controllerRef.playAgain();
			this.gameOverScreen.tryAgainBut.removeEventListener(MouseEvent.CLICK, onTryAgain);
			this.removeChild(this.gameOverScreen);
		}
		
		private function attachLevelCompletedScreen():void{
			this.levelCompletedScreen = new LevelCompletedScreen();
			this.levelCompletedScreen.x = 5;
			this.levelCompletedScreen.y = 5;
			this.levelCompletedScreen.nextLevelBut.addEventListener(MouseEvent.CLICK, playNextLevel);
			this.addChild(this.levelCompletedScreen);
		}
		
		private function playNextLevel(evt:MouseEvent):void{
			this.controllerRef.gotoNextLevel();
			this.levelCompletedScreen.nextLevelBut.removeEventListener(MouseEvent.CLICK, onTryAgain);
			this.removeChild(this.levelCompletedScreen);
			this.gameState.levelTxt.text = "Level "+ this.modelRef.level;
		}
		
		public function gameOver():void{
			this.clearAssets();
			this.attachGameOverScreen();
		}
		
		public function levelCompleted():void{
			this.clearAssets();
			this.attachLevelCompletedScreen();
		}
		
		public function onCollapseBrick():void{
			this.modelRef.collapseBrick();
			this.gameState.scoreTxt.text = "Score "+ this.modelRef.score;
		}

	}
	
}


