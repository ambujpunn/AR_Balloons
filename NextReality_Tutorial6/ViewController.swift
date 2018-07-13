//
//  ViewController.swift
//  NextReality_Tutorial6
//
//  Created by Ambuj Punn on 7/12/18.
//  Copyright © 2018 Ambuj Punn. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        // 4.2
        sceneView.debugOptions = ARSCNDebugOptions.showFeaturePoints
        
        // Create a new scene
        // 4.1
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        // 4.4
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        sceneView.addGestureRecognizer(gestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    // 4.5
    @objc func tapped(gesture: UITapGestureRecognizer) {
        let touchPosition = gesture.location(in: sceneView)
        
        // Translate that 2D point to a 3D point using hitTest (featurePoint), wherever there is a featurePoint, add a balloon there
        let hitTestResults = sceneView.hitTest(touchPosition, types: .featurePoint)
        
        guard let hitTest = hitTestResults.first else {
            return
        }
       
        addBalloon(hitTest: hitTest)
    }
    
    // 4.6
    func addBalloon(hitTest: ARHitTestResult) {
        let scene = SCNScene(named: "art.scnassets/red_balloon.dae")
        let balloonNode = Balloon(scene: scene!)
        balloonNode.position = SCNVector3(hitTest.worldTransform.columns.3.x, hitTest.worldTransform.columns.3.y, hitTest.worldTransform.columns.3.z)
        
        sceneView.scene.rootNode.addChildNode(balloonNode)
        
        // 5.1
        // Animate using SceneKit physics
        
        balloonNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        balloonNode.physicsBody?.isAffectedByGravity = false
        balloonNode.physicsBody?.damping = 0.0
        let xCord = 10 + Float(arc4random_uniform(20))
        let yCord = 20 + Float(arc4random_uniform(40))
        balloonNode.physicsBody?.applyForce(SCNVector3(xCord,yCord,0), asImpulse: false)
    }
}
