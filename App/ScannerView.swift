//
//  ScannerView.swift
//  App
//
//  Created by Li Xianlin on 27/7/24.
//
import SwiftUI
struct ScannerView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()

            Button("Select Image") {
               showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker()
        }
    }
}


#Preview{
    ScannerView()
}
