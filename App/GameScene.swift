import SpriteKit

@objcMembers
class GameScene: SKScene {
    
    var onScoreChange: ((Int) -> ())?
    
    var score = 0 {
        didSet {//closure works!
            onScoreChange?(score)
        }
    }
    
    var scoreLabel = SKLabelNode(fontNamed: "San Francisco")
    
    override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector(dx: 0, dy: -3) // Earth gravity
        score = 0
        
        // Uncomment this if you have a background
        // let background = SKSpriteNode(imageNamed: "background")
        // background.name = "background"
        // background.zPosition = -1
        // background.position = CGPoint(x: 190, y: 480)
        // addChild(background)
        
        for _ in 1...4 { // Number of objects at once
            GenerateCollectable()
        }
        
        // Uncomment this if you want to play background music
        // let music = SKAudioNode(fileNamed: "backgroundMusic.mp3")
        // addChild(music)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let tappedNodes = nodes(at: location)
        guard let tapped = tappedNodes.first else { return }
        
        // Determine the type of the tapped node
        if let nodeName = tapped.name {
            switch nodeName {
            case "banana", "battery", "tissue":
                score -= 1
            case "bottle", "box", "can":
                score += 2
            default:
                break
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.GenerateCollectable()
            }
            if nodeName != "scoreLabel" { // Only remove if it's not the scoreLabel
                tapped.removeFromParent()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Handle touches ended if needed
    }
    
    override func update(_ currentTime: TimeInterval) {
        for node in children {
            if node.position.y < -700 {
                if let name = node.name {
                    // Only decrease the score if the node is not one of the specified items
                    if name != "banana" && name != "tissue" && name != "battery" {
                        score -= 1
                    }
                }
                node.removeFromParent()
                self.GenerateCollectable()
            }
        }
        
        if score < 0 {
            score = 0
        }
    }
    

    func GenerateCollectable() {
        // Array of random objects
        let sprites = ["banana", "battery", "bottle", "box", "can", "tissue"]
        let spriteName = sprites.randomElement()!
        
        // Adding object
        let collectable = SKSpriteNode(imageNamed: spriteName)
        collectable.name = spriteName // Assigning the sprite's name
        collectable.size = CGSize(width: 50, height: 50)
        
        // Physics
        collectable.physicsBody = SKPhysicsBody(texture: collectable.texture!, size: collectable.size)
        collectable.physicsBody?.isDynamic = true
        collectable.physicsBody?.affectedByGravity = true
        
        collectable.texture!.filteringMode = .nearest
        
        collectable.zPosition = 0
        collectable.position = CGPoint(x: Double.random(in: 0..<250), y: -400)
        addChild(collectable)
        collectable.physicsBody?.velocity = CGVector(dx: 30, dy: 1100)
    }
}
