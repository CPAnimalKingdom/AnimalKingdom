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

    var anchor: ARPlaneAnchor!
    var planeGeometry: SCNPlane!

    init(anchor: ARPlaneAnchor) {
        super.init()

        self.anchor = anchor
        planeGeometry = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))

        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "tron_grid")

        planeGeometry.materials = [material]

        let planeNode = SCNNode(geometry: planeGeometry)
        planeNode.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z)
        // Planes in SceneKit are vertical by default so we need to rotate 90degrees
        // to match planes in ARKit
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2.0, 1.0, 0.0, 0.0);

        setTextureScale()
        addChildNode(planeNode)
    }

    // Will never be used
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setTextureScale() {
        let width = planeGeometry.width
        let height = planeGeometry.height

        // As the width/height of the plane updates, the material should
        // cover the entire plane, repeating the texture over and over. Also if the
        // grid is less than 1 unit, don't squash the texture to fit, so
        // scaling updates the texture co-ordinates to crop the texture in that case
        if let material = planeGeometry.materials.first {
            material.diffuse.contentsTransform = SCNMatrix4MakeScale(Float(width), Float(height), 1)
            material.diffuse.wrapS = SCNWrapMode.repeat
            material.diffuse.wrapT = SCNWrapMode.repeat
        }
    }

    func update(anchor: ARPlaneAnchor) {
        planeGeometry.width = CGFloat(anchor.extent.x);
        planeGeometry.height = CGFloat(anchor.extent.z);

        // When the plane is first created it's center is 0,0,0 and the nodes
        // transform contains the translation parameters. As the plane is updated
        // the planes translation remains the same but it's center is updated so
        // we need to update the 3D geometry position
        position = SCNVector3Make(anchor.center.x, 0, anchor.center.z);
        setTextureScale()
    }
}
