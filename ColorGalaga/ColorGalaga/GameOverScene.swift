//
//  GameOverScene.swift
//  ColorGalaga
//
//  Created by Arya S  Asok on 2019-06-24.
//  Copyright © 2019 Parrot. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene:SKScene {
    
    // MANDATORY CODE - JUST COPY AND PASTE
    // ---------------------------------------------
    override init(size: CGSize) {
        super.init(size:size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // YOUR CODE GOES BELOW THIS LINE
    // ---------------------------------------------
    override func didMove(to view: SKView) {
        // MARK: Create a background image:
        // --------------------------
        
        // 1. create an image node
        let bgNode = SKSpriteNode(imageNamed: "youLoose")
        
        // 2. by default, image is shown in bottom left corner
        // I want to move image to middle
        // middle x: self.size.width/2
        // middle y: self.size.height/2
        bgNode.position = CGPoint(x:self.size.width/2,
                                  y:self.size.height/2)
        
        // Force the background to always appear at the back
        bgNode.zPosition = -1
        
        // Add child to the scene
        addChild(bgNode)
    }
    
    
}

