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
    
    @IBOutlet weak var draw: UIButton!
    @IBOutlet weak var SceneView: ARSCNView!
    // Used to track the position and orientation of the device at all times
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.SceneView.showsStatistics = true
        self.SceneView.session.run(configuration)
        self.SceneView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // This is what actually helps us make the drawing app
    // This gets called every time the view is about to render a scene

    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        print("rendering")
        
        // PointOfView contains the current location and orientation of the camera
        guard let pointOfView = self.SceneView.pointOfView else {return}
        
        // The location and orientation are encoded inside the pointOfView in a transform matrix
        // To get the transform matrix we use the code below
        let transform = pointOfView.transform
        let orientation = SCNVector3(-transform.m31,-transform.m32,-transform.m33)
        let location = SCNVector3(transform.m41,transform.m42,transform.m43)
        
        // A '+' symbol can't be used to combine SCNVectors so we write the + function below
        let frontOfCamera = orientation + location
    }
}

// takes 2 arguments - the orientation vector and the location vector
func + (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    // returns new vector point created using the x field of your location plus the x field of the orientation, then the same for y and z
    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
}


 
