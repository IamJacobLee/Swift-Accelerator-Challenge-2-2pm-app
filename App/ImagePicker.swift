//
//  ImagePicker.swift
//  App
//
//  Created by J Family on 10/8/24.
//
import SwiftUI


struct ImagePicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = ViewController
    
    func makeUIViewController(context: Context) -> ViewController {
        let viewController = ViewController()
        return viewController
    }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        
    }
}
