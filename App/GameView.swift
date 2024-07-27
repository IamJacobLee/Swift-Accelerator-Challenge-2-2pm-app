//
//  GameView.swift
//  App
//
//  Created by Li Xianlin on 27/7/24.
//

import SwiftUI

struct GameView: View {
    var body: some View {
        NavigationView{
            VStack{
                Text("Pick up the recyclable items!")
                    .offset(x:-70,y:0)
                Spacer()
            }.navigationTitle("Game")
        }
    }
}

#Preview {
    GameView()
}
