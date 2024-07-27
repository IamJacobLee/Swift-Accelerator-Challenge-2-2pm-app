//
//  ContentView.swift
//  App
//
//  Created by J Family on 27/7/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ScannerView()
                .tabItem {
                    Label("Scanner", systemImage: "qrcode.viewfinder")
                }
            
            GameView()
                .tabItem {
                    Label("Game", systemImage: "gamecontroller")
                }
        }
    }
}
#Preview {
    ContentView()
}


