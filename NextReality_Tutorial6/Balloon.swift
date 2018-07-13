//
//  Balloon.swift
//  NextReality_Tutorial6
//
//  Created by Ambuj Punn on 7/12/18.
//  Copyright © 2018 Ambuj Punn. All rights reserved.
//

import Foundation
import SceneKit
import ARKit

class Balloon: SCNNode {
    
    private var scene: SCNScene!
    
    init(scene: SCNScene) {
        super.init()
        self.scene = scene
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        guard let balloonNode = self.scene.rootNode.childNode(withName: "balloon", recursively: true) else {
            return
        }
        
        self.addChildNode(balloonNode)
    }
}

