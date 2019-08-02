//
//  GameScene.swift
//  FlappyBird
//
//  Created by Eyad on 7/7/19.
//  Copyright © 2019 Afeka. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene ,SKPhysicsContactDelegate{
    var delayBetweenObstacles = Double(2.5)
    var moveBackgroungDistance = CGFloat(1)
    var numOfLevel = Int(0)
    var score = Int(0)
    var user_name = String("")
    var labelScore = SKLabelNode()
    var labelTouchPlay = SKLabelNode()
    var labelNameOfUser = SKLabelNode()
    var clearObstacles = SKAction()
    let birds = SKTextureAtlas(named:"player")
    var obstacles = SKNode()
    var nameOfGame = SKSpriteNode()
    var allBirds = Array<Any>()
    var labelNameOfLevel = SKLabelNode()
    var beginGame = false
    var levelTime = Int(4)
    var timeRemaining = Int(4)
    var gameOver = false
    var bird = SKSpriteNode()
    var timer = Timer()
    var isWinnerLevel = false
    var animationBird = SKAction()
    var buttonBack = SKSpriteNode()
    var buttonNextLevel = SKSpriteNode()
    var gameVC: GameViewController?
    var labelCountDown = SKLabelNode()
    
    
    func timerRunning() {
        timeRemaining -= 1
        let minutesLeft = Int(timeRemaining) / 60 % 60
        let secondsLeft = Int(timeRemaining) % 60
        if(minutesLeft == 0){
            labelCountDown.text = "\(secondsLeft)"
        }
        else{
            labelCountDown.text = "\(minutesLeft):\(secondsLeft)"
        }
        
        if(timeRemaining <= 0){
            isWinnerLevel = true
            levelDone()
        }
        
    }
    

    override func didMove(to view: SKView) {
        gameSceneInit()
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        if (beginGame == true)
        {
            if (gameOver == false)
            {
                enumerateChildNodes(withName: "background", using: ({(node, error) in
                    let background = node as! SKSpriteNode
                    background.position = CGPoint(x: background.position.x - self.moveBackgroungDistance, y: background.position.y)
                    if background.position.x <= -background.size.width {
                        background.position = CGPoint(x:background.position.x + background.size.width * 2, y:background.position.y)
                    }
                }))
            }
        }
    }
    
    
    
    func levelDone() {
        enumerateChildNodes(withName: "obstacles", using: ({
            (node, error) in
            node.speed = 0
            self.removeAllActions()
        }))
        
        timer.invalidate()
        timeRemaining = levelTime
        nextLevelInitButton()
        self.bird.removeAllActions()
        self.bird.removeFromParent()
        gameOver = true
    }
    
    
    func gameSceneInit(){
        allBirds.append(birds.textureNamed("bird1"))
        allBirds.append(birds.textureNamed("bird2"))
        allBirds.append(birds.textureNamed("bird3"))
        allBirds.append(birds.textureNamed("bird4"))
        self.physicsWorld.contactDelegate = self
        self.backgroundColor = SKColor(red: 80.0/255.0, green: 192.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.collisionBitMask = birdItem
        self.physicsBody?.categoryBitMask = floorItem
        self.physicsBody?.contactTestBitMask = birdItem
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        
        for i in 0..<2
        {
            let background = SKSpriteNode(imageNamed: "bg")
            background.size = (self.view?.bounds.size)!
            background.anchorPoint = CGPoint.init(x: 0, y: 0)
            background.position = CGPoint(x:CGFloat(i) * self.frame.width, y:0)
            background.name = "background"
            self.addChild(background)
        }
        
        self.bird = birdInit()
        self.addChild(bird)
        nameOfGameInit()
        let animateBird = SKAction.animate(with: self.allBirds as! [SKTexture], timePerFrame: 0.1)
        self.animationBird = SKAction.repeatForever(animateBird)
        labelScore = scoreInitLabel()
        labelNameOfUser = nameOfUserInitLabel()
        labelNameOfLevel = nameOfLevelInitLabel()
        labelCountDown = countDownInitLabel()
        labelTouchPlay = touchPlayInitLabel()
        self.addChild(labelTouchPlay)
        self.addChild(labelCountDown)
        self.addChild(labelNameOfLevel)
        self.addChild(labelScore)
        self.addChild(labelNameOfUser)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (beginGame == false)
        {
            if let nameuser = self.userData?.value(forKey: "username"){
                labelNameOfUser.text = "\(nameuser)"
                user_name = "\(nameuser)"
            }
            beginGame =  true
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerRunning), userInfo: nil, repeats: true)
            
            numOfLevel += 1
            labelNameOfLevel.text = "Level: \(numOfLevel)"
            bird.physicsBody?.affectedByGravity = true
            nameOfGame.run(SKAction.scale(to: 0.5, duration: 0.3), completion: {
                self.nameOfGame.removeFromParent()
            })
            labelTouchPlay.removeFromParent()
            self.bird.run(animationBird)
            let spawn = SKAction.run({
                () in
                self.obstacles = self.obstaclesInit()
                self.addChild(self.obstacles)
            })
            
            let obstaclesDelay = SKAction.wait(forDuration: delayBetweenObstacles)
            let delay = SKAction.sequence([spawn, obstaclesDelay])
            let delayForever = SKAction.repeatForever(delay)
            self.run(delayForever)
            let dis = CGFloat(self.frame.width + obstacles.frame.width)
            clearObstacles = SKAction.sequence([SKAction.moveBy(x: -dis - 50, y: 0, duration: TimeInterval(0.008 * dis)), SKAction.removeFromParent()])
            bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 40))
        } else {
            if gameOver == false {
                bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 40))
            }
        }
        
        
        for touch in touches{
            let location = touch.location(in: self)
            
            if (isWinnerLevel == true){
                if buttonNextLevel.contains(location){
                    initNewLevel()
                }
            }
            
            if (gameOver == true) {
                
                if buttonBack.contains(location){
                    if UserDefaults.standard.object(forKey: "highestScore") != nil {
                        let hscore = UserDefaults.standard.integer(forKey: "highestScore")
                        if hscore < Int(labelScore.text!)!{
                            UserDefaults.standard.set(labelScore.text, forKey: "highestScore")
                        }
                    } else {
                        UserDefaults.standard.set(0, forKey: "highestScore")
                    }
                    let s = Score(name: user_name!, level: numOfLevel, score: score)
                    Score.save(score: s)
                    backGame()
                }
            }
        }
    }
    
    
    func backGame(){
        self.removeAllChildren()
        self.removeAllActions()
        gameVC?.dismiss(animated: true)
        gameOver = false
        beginGame = false
        isWinnerLevel = false
        score = 0
        moveBackgroungDistance = 1
        delayBetweenObstacles = 2.5
        numOfLevel = 0
        timeRemaining = levelTime
    }
    

    func didBegin(_ contact: SKPhysicsContact) {
        let ringCoin = SKAction.playSoundFileNamed("ringCoin.mp3", waitForCompletion: false)
        let item1 = contact.bodyA
        let item2 = contact.bodyB
        
        if (item1.categoryBitMask == coinItem && item2.categoryBitMask == birdItem) {
            run(ringCoin)
            item1.node?.removeFromParent()
            score += 1
            labelScore.text = "\(score)"
        } else
            if (item1.categoryBitMask == birdItem && item2.categoryBitMask == coinItem) {
                run(ringCoin)
                item2.node?.removeFromParent()
                score += 1
                labelScore.text = "\(score)"
        } else
                if (item1.categoryBitMask == birdItem && item2.categoryBitMask == floorItem || item1.categoryBitMask == birdItem && item2.categoryBitMask == obstacleItem || item1.categoryBitMask == floorItem && item2.categoryBitMask == birdItem || item1.categoryBitMask == obstacleItem && item2.categoryBitMask == birdItem) {
                    enumerateChildNodes(withName: "obstacles", using: ({
                        (node, error) in
                        self.removeAllActions()
                        node.speed = 0
                    }))
                    if gameOver == false{
                        timer.invalidate()
                        timeRemaining = levelTime
                        gameOver = true
                        backInitButton()
                        self.bird.removeAllActions()
                    }
        }
 
    }
    
    
    func initNewLevel() {
        self.removeAllChildren()
        self.removeAllActions()
        isWinnerLevel = false
        gameOver = false
        beginGame = false
        timeRemaining = levelTime
        moveBackgroungDistance += 2
        delayBetweenObstacles -= 0.1
        gameSceneInit()
    }
    
}
