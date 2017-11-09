//
//  ARPlane.swift
//  AnimalKingdom
//
//  Created by Nader Neyzi on 10/19/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit
import ARKit

class ARPlane: SCNNode {

    var planeAnchor: ARPlaneAnchor!
    var planeGeometry: SCNPlane!

    init(_ planeAnchor: ARPlaneAnchor) {
        super.init()

        self.planeAnchor = planeAnchor
        planeGeometry = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))

//        let material = SCNMaterial()
//        material.diffuse.contents = UIImage(named: "tron_gridGreen2")
//        planeGeometry.materials = [material]
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.clear
        planeGeometry.materials = [material]


        let planeNode = SCNNode(geometry: planeGeometry)
        planeNode.position = SCNVector3Make(planeAnchor.center.x, 0, planeAnchor.center.z)
        // Planes in SceneKit are vertical by default so we need to rotate 90degrees
        // to match planes in ARKit
        planeNode.eulerAngles.x = -.pi / 2

        setTextureScale()
        addChildNode(planeNode)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setTextureScale() {
//        let width = planeGeometry.width
//        let height = planeGeometry.height
//
//        if let material = planeGeometry.materials.first {
//            material.diffuse.contentsTransform = SCNMatrix4MakeScale(Float(width), Float(height), 1)
//            material.diffuse.wrapS = SCNWrapMode.repeat
//            material.diffuse.wrapT = SCNWrapMode.repeat
//        }
    }

    func update(planeAnchor: ARPlaneAnchor) {
        planeGeometry.width = CGFloat(planeAnchor.extent.x);
        planeGeometry.height = CGFloat(planeAnchor.extent.z);

        position = SCNVector3Make(planeAnchor.center.x, 0, planeAnchor.center.z);
        setTextureScale()
    }
}
