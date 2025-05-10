//
//  GameplayScene.swift
//  DogDash
//
//  Created by Aynin Sheikh on 4/18/25.
//

import SwiftUI
import SpriteKit

// Complex gameplayscene class that icorporates the methods associated with Spritekit
class GameplayScene: SKScene, SKPhysicsContactDelegate {
    var player:SKSpriteNode!
        
    var itemBar:SKSpriteNode!
    
    var healthImages = [SKSpriteNode]()
    var totalHealth:Int = 3
    
    var coinsLabel:SKLabelNode!
    var totalCoins:Int = 0
    var coinImage:SKSpriteNode!

    
    var distanceLabel:SKLabelNode!
    var distance:Int = 0 {
        didSet {
            distanceLabel.text = "Distance: \(distance)m"
        }
    }
    
    var gameTime:TimeInterval = 0
    var updateTime:TimeInterval = 0
    
    var objectTimer:Timer!
    
    var isTouch:Bool = false
    
    var laserTimeDifference: TimeInterval = 0
    var laserInterval: TimeInterval = 0.6
    
    let playerMask:UInt32 = 0x1
    let enemyMask:UInt32 = 0x1 << 1
    let laserMask:UInt32 = 0x1 << 2
    let coinMask:UInt32 = 0x1 << 3
    let enemyLaserMask:UInt32 = 0x1 << 4
    
    var gameOverText:SKLabelNode?
    var distanceTotalLabel:SKLabelNode?
    var coinsTotalLabel:SKLabelNode?
    var restartButtonLabel:SKLabelNode?
    var mainMenuButtonLabel:SKLabelNode?

    var gameOverBackground:SKSpriteNode?
        
    override func didMove(to view: SKView) {
        
        // Firstly, we have our background image that is adjusted to fit the screen and placed behind all the objects
        let background = SKSpriteNode(imageNamed: "space3")
        background.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        background.zPosition = -1

        let widthRatio = self.frame.width / background.size.width
        let heightRatio = self.frame.height / background.size.height
        let aspectRatio = max(widthRatio, heightRatio)
        
        background.setScale(aspectRatio)
        
        addChild(background)
        
        // Player sprite node and handling its physics and also positioning the the node accordingly
        player = SKSpriteNode(imageNamed: JSONClass.singleInstance.getCurrentDog()!)
        player.position = CGPoint(x: self.frame.size.width / 6, y: frame.height / 2)
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.categoryBitMask = playerMask
        player.physicsBody?.contactTestBitMask = coinMask | enemyLaserMask
        player.physicsBody?.collisionBitMask = 0
        
        addChild(player)
        
        
        // Physics of the world and handling the contact respectively
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        
        // Item bar node for holding the health, coins, and distance
        itemBar = SKSpriteNode(color: .orange, size: CGSize(width: frame.size.width, height: 100))
        itemBar.position = CGPoint(x: frame.size.width / 2 , y: frame.size.height - 50)
        addChild(itemBar)
        
        // Distance label node that displays the distance and increments by 1 meter every second
        distanceLabel = SKLabelNode(text: "Distance: 0m")
        distanceLabel.position = CGPoint(x: 135, y: self.frame.size.height - 80)
        distanceLabel.fontName = "AmericanTypewriter-Bold"
        
        addChild(distanceLabel)
        
        // Here we add the respective hearts for putting the health images/nodes
        addHearts()
        
        // The coin image node that
        coinImage = SKSpriteNode(imageNamed: "coinGold")
        coinImage.position = CGPoint(x: 300, y: self.frame.size.height - 70)
        
        addChild(coinImage)
        
        coinsLabel = SKLabelNode(text: "0")
        coinsLabel.fontName = "AmericanTypewriter-bold"
        coinsLabel.position = CGPoint(x: 350, y: self.frame.size.height - 85)
        coinsLabel.fontSize = 40
        addChild(coinsLabel)
        updateCoinLabel()
        
        objectTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(addEnemy), userInfo: nil, repeats: true)
    

    }
    
    // Generally speaking this establishes the location that the user touches the screen and also for creating a button-like touch press for when the game is over in that respective area
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)

        if player.contains(location) {
            isTouch = true
        }
        for touchPress in touches {
            let touchLocation = touchPress.location(in: self)
            let touchedNodeName = self.atPoint(touchLocation)
            
            if touchedNodeName.name == "restartButton" {
                restartGame()
            } else if touchedNodeName.name == "mainMenuButton" {
                switchToMainMenu()
            }
        }
    }
    // Touches moved helps drag the dog node up and down respectively when the player touches the dog
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isTouch, let touch = touches.first else { return }
        
        let location = touch.location(in: self)

        let boundY = min(max(location.y, 40), 750)
        
        player.position = CGPoint(x: player.position.x, y: boundY)

    }
    
    // This is for when the player stops touching the node, we set a bool variable to false
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isTouch = false
    }
    
    // The update function updates every second (fps function) and constantly updates the distance and time, along with checking the screen for any touches
    override func update(_ currentTime: TimeInterval) {
        
        let timeDifference:TimeInterval
        
        if gameTime == 0 {
            gameTime = currentTime
        }
        
        timeDifference = currentTime - gameTime
        gameTime = currentTime
        updateTime = updateTime + timeDifference
        
        if updateTime > 1.0 {
            distance += 1
            updateTime = 0
        }
        
        if isTouch && currentTime - laserTimeDifference > laserInterval {
            fireLaser()
            laserTimeDifference = currentTime
        }
        
    }
    
    // Didbegin is mainly for creating the physics of the world when the scene starts as it
    func didBegin(_ contact: SKPhysicsContact) {
        var bodyOne:SKPhysicsBody
        var bodyTwo:SKPhysicsBody
        
        // Establish physics body contact masks and in general the body
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            bodyOne = contact.bodyA
            bodyTwo = contact.bodyB
        }
        else {
            bodyOne = contact.bodyB
            bodyTwo = contact.bodyA
        }
        
        // Check for contact with the enemy and the player's laser collision
        if (bodyOne.categoryBitMask & enemyMask) != 0 && (bodyTwo.categoryBitMask & laserMask) != 0 {
            laserCollisionEnemy(enemy: bodyOne.node as! SKSpriteNode, laser: bodyTwo.node as! SKSpriteNode)
                   
        }

        // Check for contact with the player and coin's and handle collisions
        if (bodyOne.categoryBitMask & playerMask) != 0 &&
               (bodyTwo.categoryBitMask & coinMask) != 0 {
            coinCollision(coin: bodyOne.node as! SKSpriteNode, player: bodyTwo.node as! SKSpriteNode)
                
        }
        
        // Check for contact with the player and an enemy laser and handle laser collisions with the player
        if (bodyOne.categoryBitMask & enemyLaserMask) != 0 &&
               (bodyTwo.categoryBitMask & playerMask) != 0 {
            laserCollisionPlayer(enemyLaser: bodyOne.node as! SKSpriteNode, player: bodyTwo.node as! SKSpriteNode)
                
        }
        else if (bodyTwo.categoryBitMask & enemyLaserMask) != 0 &&
            (bodyOne.categoryBitMask & playerMask) != 0 {
                laserCollisionPlayer(enemyLaser: bodyTwo.node as! SKSpriteNode, player: bodyOne.node as! SKSpriteNode)
            }
    }
    
    // Function that handles what will occur with an enemy laser colliding with the player
    func laserCollisionPlayer (enemyLaser:SKSpriteNode, player:SKSpriteNode) {
            totalHealth -= 1
        if let recentHeart = healthImages.popLast() {
            recentHeart.removeFromParent()
            if healthImages.isEmpty {
                gameOver()
            }
        }
    }
    
    // Function that handles what will occur with a player laser colliding with the enemy
    func laserCollisionEnemy (enemy:SKSpriteNode, laser:SKSpriteNode) {
        
        run(SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false))
        
        laser.removeFromParent()
        enemy.removeFromParent()
        
        generateCoin(toX: enemy.position.x, y: enemy.position.y)
        
    }
    
    // Function that handles the adding of images of the hearts
    func addHearts() {
        var incrementSize:Int = 295
        
        for i in 0...2 {
            let healthImage = SKSpriteNode(imageNamed: "heart")
            healthImage.position = CGPoint(x: incrementSize, y: Int(self.frame.size.height) - 30)
            healthImage.size = CGSize(width: 50, height: 50)
            addChild(healthImage)
            healthImages.append(healthImage)
            incrementSize += 35
        }
    }
    
    // Function that handles the collision between the player and coins
    func coinCollision (coin:SKSpriteNode, player:SKSpriteNode) {
        totalCoins += 1
        player.removeFromParent()
        run(SKAction.playSoundFileNamed("coin.wav", waitForCompletion: false))
        updateCoinLabel()
    }
    
    // Function that generates the coins when the player takes down an enemy
    func generateCoin(toX x: CGFloat, y: CGFloat) {
        
        let coin = SKSpriteNode(imageNamed: "coinGold")
        
        coin.name = "coin"
        
        coin.size = CGSize(width: 50, height: 50)
        
        coin.physicsBody = SKPhysicsBody(circleOfRadius: coin.size.width / 2)
        coin.physicsBody?.categoryBitMask = coinMask
        coin.physicsBody?.contactTestBitMask = playerMask
        coin.physicsBody?.collisionBitMask = 0
        
        coin.zPosition = 0
        
        coin.position = CGPoint(x: x, y: y)
        
        coin.texture!.filteringMode = .nearest
        
        
        addChild(coin)
        
        let coinDuration:TimeInterval = 3
        
        var coinAction = [SKAction]()
        
        coinAction.append(SKAction.moveTo(x: -coin.size.width / 2, duration: coinDuration))
        coinAction.append(SKAction.removeFromParent())
        
        coin.run(SKAction.sequence(coinAction))
        
    }
    
    // This method updates the coin label within the itembar
    func updateCoinLabel() {
        coinsLabel.text = "\(totalCoins)"
    }
    
    // Here this method adds an enemy to the game scene and handling its position as well as an enemy firing lasers
    @objc func addEnemy() {
        
        let enemy = SKSpriteNode(imageNamed: "alien")
        
        let randomXPosition = size.width + enemy.size.width / 2
        let randomYPosition = CGFloat.random(in: 0...700)
        
        enemy.position = CGPoint(x: randomXPosition, y: randomYPosition)
        enemy.size = CGSize(width: 200, height: 200)
        
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody?.isDynamic = true
        enemy.physicsBody?.categoryBitMask = enemyMask
        enemy.physicsBody?.contactTestBitMask = laserMask
        enemy.physicsBody?.collisionBitMask = 0
        
        addChild(enemy)
        
        let enemyDuration:TimeInterval = 5
        
        var enemyAction = [SKAction]()
        
        enemyAction.append(SKAction.moveTo(x: -enemy.size.width / 2, duration: enemyDuration))
        enemyAction.append(SKAction.removeFromParent())
        
        let enemyFiringLaser = SKAction.run {
            self.enemyFireLaser(enemy: enemy)
        }
        enemyAction.append(SKAction.wait(forDuration: 1.5))
        enemyAction.append(enemyFiringLaser)
        
        let laserInterval: TimeInterval = 2.2
            let laserAction = SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: laserInterval), enemyFiringLaser]))

        enemy.run(laserAction)
        
        enemy.run(SKAction.sequence(enemyAction))
        
    }

    // This method handles the player firing lasers and the positioning of them
    func fireLaser() {
        // This function provides the basis for the attack that the player and the enemey use against each other
        let laser = SKSpriteNode(imageNamed: "laser")
        
        laser.size = CGSize(width: 100, height: 100)
        laser.position = player.position
        laser.position.x += 5
        
        laser.physicsBody = SKPhysicsBody(circleOfRadius: laser.size.width / 2)
        laser.physicsBody?.isDynamic = true
        
        laser.physicsBody?.categoryBitMask = laserMask
        laser.physicsBody?.contactTestBitMask = enemyMask
        laser.physicsBody?.collisionBitMask = 0
        laser.physicsBody?.usesPreciseCollisionDetection = true
        
        addChild(laser)
        
        let laserDuration:TimeInterval = 0.5
        
        var laserArray = [SKAction]()
        
        laserArray.append(SKAction.move(to: CGPoint(x: self.frame.size.width + 10, y: player.position.y), duration: laserDuration))
        laserArray.append(SKAction.removeFromParent())
        
        laser.run(SKAction.sequence(laserArray))
    }
    
    //  This function handles the enemy firing the laser and its positioning
    func enemyFireLaser(enemy:SKSpriteNode) {
        
        let laser = SKSpriteNode(imageNamed: "laser2")
        
        laser.size = CGSize(width: 100, height: 100)
        laser.position = CGPoint(x: enemy.position.x - enemy.size.width / 2, y: enemy.position.y)
        
        laser.physicsBody = SKPhysicsBody(circleOfRadius: laser.size.width / 2)
        laser.physicsBody?.isDynamic = true
        
        laser.physicsBody?.categoryBitMask = enemyLaserMask
        laser.physicsBody?.contactTestBitMask = playerMask
        laser.physicsBody?.collisionBitMask = 0
        laser.physicsBody?.usesPreciseCollisionDetection = true
        
        addChild(laser)
        
        let laserDuration:TimeInterval = 0.5
        
        var laserArray = [SKAction]()
        
        laserArray.append(SKAction.moveBy(x: -500, y: 0, duration: laserDuration))
        laserArray.append(SKAction.removeFromParent())
        
        laser.run(SKAction.sequence(laserArray))
    }
    
    // This method handles the game over details and what occurs when the player loses all its health as they can either restart or go to the main menu
    func gameOver() {
        
        JSONClass.singleInstance.updatePlayerCoins(newCoins: totalCoins)
        
        if gameOverBackground == nil {
            gameOverBackground = SKSpriteNode(color: .blue, size: CGSize(width: 250, height: 250))
            gameOverBackground?.zPosition = 0
            gameOverBackground?.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
            
            addChild(gameOverBackground!)
        }
        
        if gameOverText == nil {
            gameOverText = SKLabelNode(text: "Game Over")
            gameOverText?.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
            gameOverText?.fontSize = 30
            gameOverText?.fontName = "AmericanTypewriter-bold"
            gameOverText?.fontColor = .red
            
            addChild(gameOverText!)
        }
        
        if distanceTotalLabel == nil {
            distanceTotalLabel = SKLabelNode(text: "Distance: \(distance)m")
            distanceTotalLabel?.fontSize = 30
            distanceTotalLabel?.fontName = "AmericanTypewriter-bold"
            distanceTotalLabel?.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 30)
            
            addChild(distanceTotalLabel!)
        }
        
        if coinsTotalLabel == nil {
            coinsTotalLabel = SKLabelNode(text: "Coins: \(totalCoins)")
            coinsTotalLabel?.fontSize = 30
            coinsTotalLabel?.fontName = "AmericanTypewriter-bold"
            coinsTotalLabel?.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 60)
            
            addChild(coinsTotalLabel!)
        }
        
        if restartButtonLabel == nil {
            restartButtonLabel = SKLabelNode(text: "Restart")
            restartButtonLabel?.fontSize = 30
            restartButtonLabel?.fontName = "AmericanTypewriter-bold"
            restartButtonLabel?.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 90)
            restartButtonLabel?.name = "restartButton"
            
            addChild(restartButtonLabel!)
        }
        
        if mainMenuButtonLabel == nil {
            mainMenuButtonLabel = SKLabelNode(text: "Main Menu")
            mainMenuButtonLabel?.fontSize = 30
            mainMenuButtonLabel?.fontName = "AmericanTypewriter-bold"
            mainMenuButtonLabel?.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 120)
            mainMenuButtonLabel?.name = "mainMenuButton"
            
            addChild(mainMenuButtonLabel!)
        }

        self.isPaused = true
        
    }
    
    // This method restarts the game for if the player chooses to click this button
    func restartGame() {
        distance = 0
        totalCoins = 0
        totalHealth = 3
        
        self.removeAllActions()
        self.removeAllChildren()
        
        gameOverBackground?.removeFromParent()
        gameOverBackground = nil
        
        gameOverText?.removeFromParent()
        gameOverText = nil
        
        distanceTotalLabel?.removeFromParent()
        distanceTotalLabel = nil
        
        coinsTotalLabel?.removeFromParent()
        coinsTotalLabel = nil
        
        restartButtonLabel?.removeFromParent()
        restartButtonLabel = nil
        
        mainMenuButtonLabel?.removeFromParent()
        mainMenuButtonLabel = nil
                
        if let view = self.view {
            let newScene = GameplayScene(size: view.bounds.size)
            newScene.scaleMode = .aspectFill
            view.presentScene(scene)
        }
                    
    }
    
    // This method switches from a SKScene to a regular SwiftUI view
    // Bear in mind this doesn't totally work
    func switchToMainMenu() {
        if let viewController = self.view?.window?.rootViewController {
            let mainMenuView = ContentView()
                    
            let hostingController = UIHostingController(rootView: mainMenuView)
                    
            viewController.present(hostingController, animated: false, completion: nil)
        }
    }
}

