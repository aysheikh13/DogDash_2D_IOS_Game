//
//  GameplayView.swift
//  DogDash
//
//  Created by Aynin Sheikh on 4/18/25.
//

import SwiftUI
import SpriteKit

struct GameplayView: View {
    var body: some View {
        // Use SpritekitView to create the gameplay scene according to the size of the screen
        SpriteKitView(scene: GameplayScene(size: UIScreen.main.bounds.size))
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        
    }
}


#Preview {
    GameplayView()
}
