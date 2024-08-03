//
//  ContentView.swift
//  Catch game
//
//  Created by T Krobot on 27/7/24.
//

import SpriteKit

@objcMembers
class GameScene: SKScene{
    
    var score = 0{
        didSet{
            scoreLabel.text = "SCORE: \(score)"
        }
    }
    
    var scoreLabel = SKLabelNode(fontNamed: "San Francisco")
    
    override func didMove(to view:SKView){
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -3) //earth is -9.81
        
        scoreLabel.fontColor = UIColor.black
        scoreLabel.position = CGPoint(x:190, y:680)
        scoreLabel.zPosition = 1
        scoreLabel.name = "scoreLabel"
        scoreLabel.fontSize = 30
        addChild(scoreLabel)
        score = 0

//        let canRecycle = ["bottle", "can", "box"]
//        let cannotRecycle = ["banana", "battery", "tissue"]
        
//        let background = SKSpriteNode(imageNamed: "background")
//        background.name = "background"
//        background.zPosition = -1
//        background.position = CGPoint(x:190, y:480)
//        addChild(background) -> is it needed?
        
        for index in 1...4{ //number of object at once
            
            GenerateCollectable()
        }
        
//        let music = SKAudioNode(fileNamed: <#T##String#>)
//        addChild(music)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let tappedNodes = nodes(at: location)
        guard let tapped = tappedNodes.first else { return }
        
        if tapped.name != "background" { //if object is touched
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                self.GenerateCollectable()
            }
            score += 2
            tapped.removeFromParent() //remove object
            
        }
        //Problem: how to minus score for some sprite?
        //future: tap on recyclable +2, leave recyclable -0 + tap on unrecyclable -2, leave unrecyclable +0
        //current: tap on any +2, leave any -1
        
        //        if tapped.name != "background"  && canRecycle{
        //            score += 2
        //        }else {
        //            score -= 2
        //        } (failed miserably)
        
//        if tapped.name == "bottle" {
//            score += 4
//            tapped.removeFromParent()
//        } (failed miserably too) aaaa
            
            
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        for node in children{
            if node.position.y < -700{
                node.removeFromParent()
                self.GenerateCollectable()
                score -= 1
            }
        }
        
        if score < 0{
            score = 0
//            GameOver()
            print("game over")
        }
    }
    
    func GameOver(){   //got some problem
        isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7){
            for node in self.children{
                if node.name == "scoreLabel" || node.name == "background" { continue }
                
                node.removeFromParent()
            }
        }
        scoreLabel.removeFromParent()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
            if let scene = GameScene(fileNamed: "GameScene"){ //needs the sks, how?
                scene.scaleMode = .aspectFill
                self.view?.presentScene(scene)
            }
        }
    }
    
    func GenerateCollectable(){ //works yay
        
        //array of random objects
        let sprites = ["banana", "battery", "bottle", "box", "can", "tissue" ]
        let spriteName = sprites.randomElement()!
        
        //adding object
        let collectable = SKSpriteNode(imageNamed: spriteName)
        collectable.name = "collectable"
        collectable.size = CGSize(width: 50, height: 50)
        
        //physics
        collectable.physicsBody = SKPhysicsBody(texture: collectable.texture!, size: collectable.size)
        collectable.physicsBody?.isDynamic = true
        collectable.physicsBody?.affectedByGravity = true
        
        collectable.texture!.filteringMode = .nearest
        
        
        collectable.zPosition = 0 //background doesnt overlap positions
        collectable.position = CGPoint(x: Double.random(in: 0..<250), y: -400) //comes from below randomly
        addChild(collectable)
        collectable.physicsBody?.velocity = CGVector(dx: 30, dy: 1000) //goes up + falls down due to gravity
    }
}
