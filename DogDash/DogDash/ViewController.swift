//
//  ViewController.swift
//  DogDash
//
//  Created by Aynin Sheikh on 5/9/25.
//

import SwiftUI
import SpriteKit

// View controller for switching from the spritekit game scene and to a static contentview()
// THemain issues
class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let skView = view as? SKView {
            let scene = GameplayScene(size: skView.bounds.size)
            scene.scaleMode = .aspectFill
            skView.presentScene(scene)
        }
        

    }

}
