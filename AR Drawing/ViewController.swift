//
//  ViewController.swift
//  AR Drawing
//
//  Created by Arrianne O'shea on 13/04/2020.
//  Copyright © 2020 Arrianne Barker. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    @IBOutlet weak var sceneView: ARSCNView!
    // Used to track the position and orientation of the device at all times
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.showsStatistics = true
        self.sceneView.session.run(configuration)
        self.sceneView.delegate = self
           
    }
    
    // This is what actually helps us make the drawing app
    // This gets called every time the view is about to render a scene

    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        print("rendering")
        
        // PointOfView contains the current location and orientation of the camera
        guard let pointOfView = sceneView.pointOfView else {return}
        
        // The location and orientation are encoded inside the pointOfView in a transform matrix
        // To get the transform matrix we use the code below
        let transform = pointOfView.transform
        let orientation = SCNVector3(transform.m31,transform.m32,transform.m33)
        let location = SCNVector3(transform.m41,transform.m42,transform.m43)
    }

}

