//
//  GameViewController.swift
//  ColorGalaga
//
//  Created by Arya S  Asok on 2019-06-24.
//  Copyright © 2019 Parrot. All rights reserved.
//


import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize the initial game scene
        let scene = GameScene(size:view.frame.size)
        let skView = view as! SKView
        
        // add some debug info to the screen
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        // additional configuration options
        
        
        // show the scene
        skView.presentScene(scene)
        
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
