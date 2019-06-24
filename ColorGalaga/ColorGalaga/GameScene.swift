//
//  GameScene.swift
//  ColorGalaga
//
//  Created by Arya S  Asok on 2019-06-24.
//  Copyright © 2019 Parrot. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let screenSize = UIScreen.main.bounds.size
    var player = SKSpriteNode()
    
    // keep track of all the Node objects on the screen
    var bullets : [SKSpriteNode] = []
    var enemies : [SKSpriteNode] = []
    let ScoreLabel = SKLabelNode(text: "Score: ")
    let LivesLabel = SKLabelNode(text: "Lives: ")
    var score = 0
    var lives = 4
    
    override func didMove(to view: SKView) {
        
        
        self.setupPlayer()
        self.Enemies()
        //add score label
        self.ScoreLabel.text = "Score: \(self.score)"
        self.ScoreLabel.fontName = "Avenir-Bold"
        self.ScoreLabel.fontColor = UIColor.yellow
        self.ScoreLabel.position = CGPoint(x:100, y:self.size.height - 800)
        
        //add lives label
        self.LivesLabel.text = "Lives: \(self.lives)"
        self.LivesLabel.fontName = "Avenir-Bold"
        self.LivesLabel.fontColor = UIColor.yellow
        self.LivesLabel.position = CGPoint(x:100, y:self.size.height - 100)
        
        addChild(self.ScoreLabel)
        addChild(self.LivesLabel)
    }
    
    // variable to keep track of how much time has passed
    var timeOfLastUpdate:TimeInterval?
    
    override func update(_ currentTime: TimeInterval) {
        
        if (timeOfLastUpdate == nil) {
            timeOfLastUpdate = currentTime
        }
        
        let timePassed = (currentTime - timeOfLastUpdate!)
        if (timePassed >= 1) {
            timeOfLastUpdate = currentTime
            // create a bullet
            self.createBullet()
           
        }
        
        
        self.detectCollision()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let locationTouched = touches.first else {
            return
        }
        
        let mousePosition = locationTouched.location(in: self)
        let moveAction = SKAction.moveTo(x: mousePosition.x, duration: 0.5)
        player.run(moveAction)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let locationTouched = touches.first else {
            return
        }
        
        let mousePosition = locationTouched.location(in: self)
        let moveAction = SKAction.moveTo(x: mousePosition.x, duration: 0.2)
        player.run(moveAction)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    
    func setupPlayer(){
        player = SKSpriteNode.init(texture: SKTexture(imageNamed: "player.png"))
        player.size = CGSize.init(width: 50, height: 50)
        player.position = CGPoint.init(x: (screenSize.width/2), y: 80)
        addChild(player)
    }
    
    func Enemies(){
        
    let numofEnemies : Int = 30
    let difference : CGFloat = 20.0
        let height : CGFloat = 40.0
        let width : CGFloat = 40.0
        
        var xPosition : CGFloat = width + difference
        var yPosition : CGFloat = screenSize.height - (height + difference)
        
        
        for eIndex in 0...numofEnemies{
            print(eIndex)
            
            let enemy = SKSpriteNode.init(texture: SKTexture(imageNamed: self.getEnemyImageName()))
            enemy.size = CGSize.init(width: width, height: height)
            enemy.zPosition = 1
            enemy.position = CGPoint.init(x: xPosition, y: yPosition)
            addChild(enemy)
            enemies.append(enemy)
            
            xPosition += difference + width
            if xPosition >= screenSize.width - difference{
                yPosition -= height + difference
                xPosition = width + difference
            }
        }
    }
    
    func getEnemyImageName() -> String{
        let enemyImageIndex = Int(CGFloat(arc4random_uniform(UInt32(3))))
        
        switch enemyImageIndex {
        case 0:
            return "redenemy.png"
        case 1:
            return "GreenEnemy.png"
        case 2:
            return "BlueEnemy.png"
        default:
            return "redenemy.png"
        }
        
    }
    
    func createBullet() {
        
        let bullet = SKSpriteNode(imageNamed:"bullets.png")
        
        // generate a location (x,y) for the bullet
        let bulletX = Int(CGFloat(player.position.x))
        let bulletY = Int(CGFloat(player.position.y))
        
        bullet.position = CGPoint(x:bulletX, y:bulletY)
        
        let bulletDestination = CGPoint(x: player.position.x, y: frame.size.height + bullet.frame.size.height / 2)
        
        //addChild(bullet)
        self.fireBullet(bullet: bullet, toDestination: bulletDestination,withDuration: 1.0,andSoundFileName: "")
        
        // add the bullet to the  array
        self.bullets.append(bullet)
        
    }
    
    func fireBullet(bullet: SKNode, toDestination destination: CGPoint, withDuration duration: CFTimeInterval, andSoundFileName soundName: String) {
        let bulletAction = SKAction.sequence([SKAction.move(to: destination, duration: duration)])
        
        bullet.run(SKAction.group([bulletAction]))
        
        // add the bullet to the scene
        addChild(bullet)
    }
    
    
    
    func detectCollision(){
        
        for (enemyIndex, enemy) in enemies.enumerated() {
            
            for (arrayIndex, bullet) in bullets.enumerated() {
                
                if bullet.intersects(enemy){
                    
                    enemy.removeFromParent()
                    self.enemies.remove(at: enemyIndex)
                    
                    
                    bullet.removeFromParent()
                    self.bullets.remove(at: arrayIndex)
                    self.score = self.score + 1
                    self.ScoreLabel.text = "Score: \(self.score)"
                    
                }
                
                if (bullet.position.y >= self.size.height)  {
                    //top of screen
                    bullet.removeFromParent()
                    self.bullets.remove(at: arrayIndex)
                }
                
            }
            
            
if enemy.intersects(player){
    enemy.removeFromParent()
                self.enemies.remove(at: enemyIndex)
                self.lives = self.lives - 1
                self.LivesLabel.text = "Lives: \(self.lives)"
    if(self.lives == 0){
        let loseScene = GameOverScene(size: self.size)
        loseScene.scaleMode = self.scaleMode
        let transitionEffect = SKTransition.flipHorizontal(withDuration: 2)
            self.view?.presentScene(loseScene, transition: transitionEffect)
                }
            
            }
            
            if (enemy.position.y <= 0.0)  {
                //Bottom of screen
                enemy.removeFromParent()
                self.enemies.remove(at: enemyIndex)
            }
            
        }
        
        
    }
}
