//
//  GameView.swift
//  App
//
//  Created by Li Xianlin on 27/7/24.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    @State private var showingSheet = false
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    //define scene
    var scene: SKScene{
        let scene = GameScene()
        scene.size = CGSize(width: screenWidth, height: screenHeight)
        scene.scaleMode = .fill
        scene.backgroundColor = .white
        return scene
    }
    
    var body: some View {
        NavigationView{
            NavigationStack{
                VStack{
                    SpriteView(scene: scene)
                        .frame(width: screenWidth, height: screenHeight)
                        .edgesIgnoringSafeArea(.all)
                }
                .navigationTitle("Game")
                .toolbar {
                    Button("Instructions") {
                        showingSheet.toggle()
                    }
                    .sheet(isPresented: $showingSheet) {
                        InstructionsView()
                    }
                }
            }
        }
    }}
#Preview {
    GameView()
}
