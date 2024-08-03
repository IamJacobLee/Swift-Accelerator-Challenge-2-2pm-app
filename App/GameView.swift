import SwiftUI
import SpriteKit

struct GameView: View {
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    @State private var score = 0
    @State private var isGameOver = false

    // Function to create a new scene
    func createScene() -> SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: screenWidth, height: screenHeight)
        scene.onScoreChange = { newScore in
            score = newScore
            // Check if the game is over
            if newScore < 0 {
                isGameOver = true
            }
        }
        scene.scaleMode = .fill
        scene.backgroundColor = .white
        return scene
    }

    // Variable to hold the current scene
    @State private var scene = SKScene()

    var body: some View {
        NavigationView {
            VStack {
                if isGameOver {
                    Text("Game Over")
                        .font(.largeTitle)
                        .padding()
                    
                    Button(action: restartGame) {
                        Text("Restart Game")
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        
                        
                    }
                } else {
                    Text("Score: \(score)")
                        .font(.largeTitle)
                        .padding()
                    
                    SpriteView(scene: scene)
                        .edgesIgnoringSafeArea(.all)
                }
            }
            .navigationTitle("Game")
            .onAppear(perform: startNewGame) // Initialize the game when the view appears
        }
    }
    
    // Function to restart the game
    private func restartGame() {
        score = 0
        isGameOver = false
        scene = createScene() // Recreate the scene
    }
    
    // Function to initialize a new game
    private func startNewGame() {
        scene = createScene()
    }
}

#Preview {
    GameView()
}
