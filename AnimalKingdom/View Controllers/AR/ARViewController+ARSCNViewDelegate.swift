//
//  ARViewController+ARSCNViewDelegate.swift
//  AnimalKingdom
//
//  Created by Nader Neyzi on 11/7/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import ARKit

extension ARViewController: ARSCNViewDelegate, ARSessionDelegate {
    // MARK: - ARSCNViewDelegate

    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        DispatchQueue.main.async {
//            self.virtualObjectInteraction.updateObjectToCurrentTrackingPosition()
            self.updateFocusSquare()
        }

        // If light estimation is enabled, update the intensity of the model's lights and the environment map
        let baseIntensity: CGFloat = 40
        let lightingEnvironment = sceneView.scene.lightingEnvironment
        if let lightEstimate = sceneView.session.currentFrame?.lightEstimate {
            lightingEnvironment.intensity = lightEstimate.ambientIntensity / baseIntensity
        } else {
            lightingEnvironment.intensity = baseIntensity
        }
    }

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }

        let plane = ARPlane.init(planeAnchor)
        planes[planeAnchor.identifier] = plane
        node.addChildNode(plane)
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let plane = planes[anchor.identifier] else { return }

        plane.update(planeAnchor: anchor as! ARPlaneAnchor)
    }

    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        // TODO: not working right now
        planes.removeValue(forKey: anchor.identifier)
    }
}
