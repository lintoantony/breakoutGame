﻿/*@author : linto (lintoka123@gmail.com)*/package com.linto.breakout.model {		import com.linto.breakout.view.GameView;		public class Model {		public static var LEFT_BOUNDARY:Number = 50;		public static var RIGHT_BOUNDARY:Number = 450;		public static var PADDLE_SPEED:Number = 10;		public static var BALL_RADIUS:Number = 15;				public var score:Number = 0;		public var lives:Number = 5;		public var totalBricks:Number = 5;		public var level:Number = 1;				private var viewRef:GameView;				public function Model() {					}				public function initializeValues():void{			this.lives = 5;			this.totalBricks = this.level * 5;		}				public function gotoNextLevel():void{			this.level++;			this.lives = 5;			this.totalBricks = this.level * 5;		}				public function setViewRef(viewRef:GameView):void{			this.viewRef = viewRef;		}				public function getLifeStatus():Number{			return lives;		}				public function decrimentLife():void{			this.lives -= 1;			if (this.lives == 0) {				this.viewRef.gameOver();			}		}				public function collapseBrick():void{			this.score++;			this.totalBricks--;			if (this.totalBricks == 0) {				this.viewRef.levelCompleted();			}		}	}	}