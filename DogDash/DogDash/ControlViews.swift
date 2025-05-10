//
//  ControlViews.swift
//  DogDash
//
//  Created by Aynin Sheikh on 4/18/25.
//

import SwiftUI
import SpriteKit

// This struct allows us to convert or represent the view as a spritekit scene, that acts like a view with some different features
struct SpriteKitView: UIViewRepresentable {
    
    var scene: SKScene
    
    func makeUIView(context: Context) -> SKView{
        let skView = SKView()
        skView.presentScene(scene)
        return skView
    }
    
    func updateUIView(_ uiView: SKView, context: Context) {}
    
}



