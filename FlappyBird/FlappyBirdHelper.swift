//
//  GameElements.swift
//  FlappyBird
//
//  Created by Eyad on 11/7/19.
//  Copyright © 2019 Afeka. All rights reserved.
//

import Foundation
import SpriteKit

let coinItem:UInt32 = 1
let obstacleItem:UInt32 = 2
let floorItem:UInt32 = 3
let birdItem:UInt32 = 4
let topItem:UInt32 = 5

extension GameScene {
    
    func nextLevelInitButton() {
        buttonNextLevel.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        buttonNextLevel.zPosition = 6
        buttonNextLevel.setScale(0)
        buttonNextLevel = SKSpriteNode(imageNamed: "next")
        buttonNextLevel.size = CGSize(width:120, height:110)
        self.addChild(buttonNextLevel)
        buttonNextLevel.run(SKAction.scale(to: 1.0, duration: 0.3))
    }
    
    
    func nameOfUserInitLabel() -> SKLabelNode {
        let labelNameOfUser = SKLabelNode()
        labelNameOfUser.fontName = "Arial"
        labelNameOfUser.position = CGPoint(x: 50, y: self.frame.height - 22)
        labelNameOfUser.text = String(format: "")
        labelNameOfUser.zPosition = 5
        labelNameOfUser.fontSize = 12
        return labelNameOfUser
    }
    
    
    func countDownInitLabel() -> SKLabelNode {
        let labelCountDown = SKLabelNode()
        labelCountDown.position = CGPoint(x: self.frame.width - 30, y: self.frame.height - 22)
        labelCountDown.text = String(format: "00:00")
        labelCountDown.zPosition = 5
        labelCountDown.fontSize = 12
        labelCountDown.fontName = "Arial"
        return labelCountDown
    }
    
    
    func birdInit() -> SKSpriteNode {
        
        let bird = SKSpriteNode(texture: SKTextureAtlas(named:"player").textureNamed("bird1"))
        bird.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
        bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.width / 2)
        bird.physicsBody?.linearDamping = 1.1
        bird.physicsBody?.restitution = 0
        bird.size = CGSize(width: 50, height: 50)
        bird.physicsBody?.contactTestBitMask = obstacleItem | coinItem | floorItem
        bird.physicsBody?.categoryBitMask = birdItem
        bird.physicsBody?.collisionBitMask = obstacleItem | floorItem
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.affectedByGravity = false
        return bird
    }
    
    
    func backInitButton() {
        buttonBack = SKSpriteNode(imageNamed: "back")
        buttonBack.size = CGSize(width:100, height:100)
        buttonBack.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        buttonBack.zPosition = 6
        buttonBack.setScale(0)
        self.addChild(buttonBack)
        buttonBack.run(SKAction.scale(to: 1.0, duration: 0.3))
    }
    
    
    func scoreInitLabel() -> SKLabelNode {
        let labelScore = SKLabelNode()
        labelScore.position = CGPoint(x: self.frame.width / 2, y: 40)
        labelScore.text = "\(score)"
        labelScore.zPosition = 5
        labelScore.fontSize = 30
        labelScore.fontName = "Arial"
        return labelScore
    }
    
    
    func nameOfGameInit() {
        nameOfGame = SKSpriteNode()
        nameOfGame = SKSpriteNode(imageNamed: "logo")
        nameOfGame.size = CGSize(width: 272, height: 65)
        nameOfGame.position = CGPoint(x:self.frame.midX, y:self.frame.midY + 100)
        nameOfGame.setScale(0.5)
        self.addChild(nameOfGame)
        nameOfGame.run(SKAction.scale(to: 1.0, duration: 0.3))
    }
    
    
    func touchPlayInitLabel() -> SKLabelNode {
        let labelTouchPlay = SKLabelNode()
        labelTouchPlay.fontColor = UIColor(red: 80/255, green: 90/255, blue: 150/255, alpha: 1.0)
        labelTouchPlay.position = CGPoint(x:self.frame.midX, y:self.frame.midY - 100)
        labelTouchPlay.zPosition = 5
        labelTouchPlay.fontSize = 15
        labelTouchPlay.fontName = "Arial"
        labelTouchPlay.text = "Touch to play!!"
        return labelTouchPlay
    }
    
    
    func obstaclesInit() -> SKNode  {
        obstacles = SKNode()
        obstacles.name = "obstacles"
        let obstacleTop = SKSpriteNode(imageNamed: "obstacle")
        let obstacleBottom = SKSpriteNode(imageNamed: "obstacle")
        let coin = SKSpriteNode(imageNamed: "coin")
        coin.size = CGSize(width: 40, height: 40)
        coin.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2)
        coin.physicsBody = SKPhysicsBody(rectangleOf: coin.size)
        coin.physicsBody?.affectedByGravity = false
        coin.physicsBody?.isDynamic = false
        coin.physicsBody?.categoryBitMask = coinItem
        coin.physicsBody?.collisionBitMask = 0
        coin.physicsBody?.contactTestBitMask = birdItem
        coin.color = SKColor.blue
        
        obstacleTop.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 + 420)
        obstacleBottom.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 - 420)
        obstacleTop.setScale(0.5)
        obstacleBottom.setScale(0.5)
        obstacleTop.physicsBody = SKPhysicsBody(rectangleOf: obstacleTop.size)
        obstacleTop.physicsBody?.categoryBitMask = obstacleItem
        obstacleTop.physicsBody?.collisionBitMask = birdItem
        obstacleTop.physicsBody?.contactTestBitMask = birdItem
        obstacleTop.physicsBody?.isDynamic = false
        obstacleTop.physicsBody?.affectedByGravity = false
        obstacleBottom.physicsBody = SKPhysicsBody(rectangleOf: obstacleBottom.size)
        obstacleBottom.physicsBody?.categoryBitMask = obstacleItem
        obstacleBottom.physicsBody?.collisionBitMask = birdItem
        obstacleBottom.physicsBody?.contactTestBitMask = birdItem
        obstacleBottom.physicsBody?.isDynamic = false
        obstacleBottom.physicsBody?.affectedByGravity = false
        obstacleTop.zRotation = CGFloat.pi
        obstacles.addChild(obstacleTop)
        obstacles.addChild(obstacleBottom)
        obstacles.zPosition = 1
        let randomPosition = random(min: -200, max: 200)
        obstacles.position.y = obstacles.position.y + randomPosition
        obstacles.addChild(coin)
        obstacles.run(clearObstacles)
        return obstacles
    }
    
    
    func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    
    func random(min : CGFloat, max : CGFloat) -> CGFloat{
        return random() * (max - min) + min
    }
    
    
    func nameOfLevelInitLabel() -> SKLabelNode {
        let labelNameOfLevel = SKLabelNode()
        labelNameOfLevel.zPosition = 5
        labelNameOfLevel.fontSize = 12
        labelNameOfLevel.position = CGPoint(x: self.frame.width/2, y: self.frame.height - 22)
        labelNameOfLevel.text = String(format: "")
        labelNameOfLevel.fontName = "Arial"
        return labelNameOfLevel
    }
    
}
