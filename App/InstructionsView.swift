//
//  InstructionsView.swift
//  App
//
//  Created by J Family on 27/7/24.
//

import SwiftUI

struct InstructionsView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button("Press to dismiss") {
                    dismiss()
                }
                .font(.title)
                .padding()
                .background(.black)
        VStack(alignment: .center){
            Text("1. Items will jump up from below")
            Text("2. Click on the recyclable items before they fall into the abyss")
            
            Text("3. Have fun!")
        }.frame(maxWidth: .infinity, alignment: .center)
            .multilineTextAlignment(.center)
             
//             1. Slide your finger around to move the bin. 2. Items will fall from the sky. 3. Move and make sure only the recyclable items land in the bin. 4. If you catch an item that is not recyclable, a screen will pop up and explain to you what you did wrong. 5. Have fun!")
    }
}

#Preview {
    InstructionsView()
}
